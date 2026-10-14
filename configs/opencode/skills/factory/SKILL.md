---
name: factory
description: "Software factory orchestrator. Use when the user runs /factory <feature>, /factory next, /factory approve <job-id>, or /factory rework <job-id> <note>. Manages the full build-review-approve loop for vertical slice feature delivery."
---

# Software Factory Orchestrator

You are the factory orchestrator. You run the build-review-approve loop, spawn every agent, and are the sole writer of `factory/board.json`. All project-scoped files live in the directory where this skill was invoked.

## Concurrent Safety for board.json

**CRITICAL**: Multiple factory orchestrators may run in parallel and share the same `factory/board.json`. Every update to `board.json` MUST be atomic and scoped to only the current job. Never read the whole file, modify in memory, and write it back without locking - this causes race conditions.

Use this pattern for EVERY write to `board.json` (create a helper script at `factory/update-board.sh` and call it for every update):

```bash
#!/usr/bin/env bash
# factory/update-board.sh - atomic, job-scoped board.json updater
# Usage: bash factory/update-board.sh <job-id> <jq-update-expression>
# Example: bash factory/update-board.sh "001-add-auth" '.stage = "build" | .round = 1'
set -euo pipefail

JOB_ID="$1"; shift
JQ_EXPR="$1"; shift
BOARD="factory/board.json"
LOCK="factory/.board.lock"

mkdir -p factory
touch "$LOCK"

(
  flock -x 200
  # Re-read current state inside the lock
  TMP=$(mktemp)
  jq --arg id "$JOB_ID" --argjson upd "{}" \
    '(.jobs[] | select(.id == $id)) as $job |
     if $job then . else .jobs += [{"id": $id}] end |
     .jobs = [.jobs[] | if .id == $id then . * ($upd) else . end]' \
    "$BOARD" > "$TMP" 2>/dev/null || true
  # Apply the caller's jq expression scoped to the job
  jq --arg id "$JOB_ID" \
    '(.jobs[] | select(.id == $id)) |= ('"$JQ_EXPR"')' \
    "$BOARD" > "$TMP"
  mv "$TMP" "$BOARD"
) 200>"$LOCK"
```

### Specific helpers (preferred over raw jq)

These helper scripts are pre-shipped in the skill's `scripts/` directory and copied to `factory/` during initialization. Use them for every board update:

```bash
# factory/board-set-stage.sh <job-id> <stage> [round]
bash factory/board-set-stage.sh "001-add-auth" "build" 1

# factory/board-set-review.sh <job-id> <reviewer> <PASS|CHANGES>
bash factory/board-set-review.sh "001-add-auth" "security" "PASS"

# factory/board-set-pr.sh <job-id> <pr-url>
bash factory/board-set-pr.sh "001-add-auth" "https://github.com/..."

# factory/board-add-job.sh <job-id> <branch> <worktree>
bash factory/board-add-job.sh "001-add-auth" "feature/001-add-auth" "/home/user/.sandbox/factory-001-add-auth"
```

### Rules for board.json updates

1. **Always lock** via `flock` on `factory/.board.lock` before reading or writing `board.json`.
2. **Re-read inside the lock** - never trust a value read before acquiring the lock.
3. **Scope updates to the current job ID** - use `select(.id == $job_id)` in jq so other jobs are preserved untouched.
4. **Never write the whole file from memory** - always use the helper scripts above.
5. Add `factory/.board.lock` to `.gitignore` alongside the other factory paths.

## The Loop

```
          ┌──────────────────┐
          │     feature      │
          └─────────┬────────┘
                    v
          ┌──────────────────┐
          │   spec-writer    │
          └─────────┬────────┘
                    v
          ┌──────────────────┐
          │     builder      │<─────────────────┐
          └─────────┬────────┘                  │
       ┌────────┬───┴───┬────────┐              │
       v        v       v        v              │
  ┌────────┐ ┌─────┐ ┌────┐ ┌──────┐           │
  │security│ │ ux  │ │ ui │ │ code │           │
  └───┬────┘ └──┬──┘ └──┬─┘ └──┬───┘           │
      └─────────┴───┬───┴──────┘               │
                    v          any CHANGES:     │
          ┌──────────────────┐  resume builder  │
          │   WAIT FOR ALL   ├──────────────────┘
          │   4 reviews in   │  (max 2 rounds)
          └─────────┬────────┘
                    v  all PASS
          ┌──────────────────┐
          │     approver     │
          └─┬───────────────┬┘
    APPROVE │               │ ESCALATE
            v               v
     ┌─────────────┐ ┌─────────────┐
     │rebase, bump │ │ needs-human │  <- /factory approve
     │version, PR  │ └─────────────┘
     └─────────────┘
```

## Commands

| Command | Action |
|---------|--------|
| `/factory <feature>` | Create a new job and run it through the loop. If `<feature>` references an existing slice (e.g., "Slice 19"), looks up the slice details from project documentation. If it's a new feature description (e.g., "dark mode"), creates a new slice. |
| `/factory next` | Run the first unchecked item in `factory/backlog.md` |
| `/factory approve <job-id>` | Approve and merge the PR for a `needs-human` job |
| `/factory rework <job-id> <note>` | Send a job back to the builder with feedback |

## Workflow

### 1. Inspect the repository

Before spawning any agent, gather project context:

- Language, framework, and build system (read `package.json`, `go.mod`, `Cargo.toml`, `pyproject.toml`, etc.)
- Test command and how to run it
- Lint/typecheck commands
- Code conventions and patterns (scan a few existing files)
- Branch naming conventions (default: `feature/<job-id>` or `bug/<job-id>` based on feature type)
- Worktree base directory (default: `$HOME/.sandbox` or as specified)
- Version file location and format (e.g., `package.json`, `pyproject.toml`, `VERSION` file)
- Record all findings in a `# Project Context` section you pass to every agent

### 2. Initialize factory structure

Before creating the first job, set up the factory directory and copy the helper scripts:

```bash
# Run the setup script from the skill directory
SKILL_DIR="/home/koax/.config/opencode/skills/factory"
bash "$SKILL_DIR/scripts/setup-factory.sh" "$SKILL_DIR"
```

This will:
- Create `factory/jobs/` directory
- Initialize `factory/board.json` if it doesn't exist
- Copy all helper scripts (`factory/update-board.sh`, `factory/board-*.sh`, `factory/checkout.sh`) from the skill's `scripts/` directory
- Add factory paths to `.gitignore`
- Inject a `checkout` target into the project's `Makefile` (or create one if it doesn't exist)

Alternatively, you can manually initialize:

```bash
mkdir -p factory/jobs

if [ ! -f factory/board.json ]; then
  echo '{"jobs": []}' > factory/board.json
fi

# Copy helper scripts from skill directory
SKILL_DIR="/home/koax/.config/opencode/skills/factory"
cp "$SKILL_DIR/scripts/"*.sh factory/
chmod +x factory/*.sh

# Ensure .gitignore entries
for pat in "factory/jobs/" "factory/board.json" "factory/.board.lock"; do
  if [ -f .gitignore ]; then
    grep -qF "$pat" .gitignore || echo "$pat" >> .gitignore
  else
    echo "$pat" > .gitignore
  fi
done
```

### 3. Resolve feature request

**IMPORTANT**: Before creating a job, determine if the feature request references an existing slice or is a new feature.

**Search for existing slices:**

Search the project directory for common planning files that may contain slice definitions:

```bash
# Look for common planning/slice files
for file in plan.md todo.md slices.md roadmap.md backlog.md PLAN.md TODO.md SLICES.md ROADMAP.md BACKLOG.md; do
  if [ -f "$file" ]; then
    echo "Found: $file"
  fi
done

# Also search for files containing "slice" in the name
find . -maxdepth 2 -type f \( -iname "*slice*" -o -iname "*plan*" -o -iname "*todo*" \) -not -path "./factory/*" -not -path "./.git/*" 2>/dev/null
```

**Analyze the feature request:**

1. **If the request matches a numbered slice pattern** (e.g., "Slice 19", "slice 19", "S19"):
   - Search the found planning files for "Slice 19" or similar references
   - Extract the full slice description and any associated details
   - Use the extracted description as the feature to implement
   - Example: User says "Implement Slice 19" → Find "Slice 19: Add user authentication" in plan.md → Use "Add user authentication" as the feature

2. **If the request is a feature description** (e.g., "dark mode", "add rate limiting"):
   - Check if this exact feature already exists in any planning file
   - If found, use the existing description and any additional context
   - If not found, treat it as a new feature and proceed with the provided description

**Resolution logic:**

```bash
# Example: User says "/factory Implement Slice 19"
# Search for slice reference in planning files

SLICE_NUM="19"
FEATURE_DESC=""

# Search in common planning files
for file in plan.md todo.md slices.md roadmap.md; do
  if [ -f "$file" ]; then
    # Look for patterns like "Slice 19:", "## Slice 19", "- Slice 19:", "S19:", etc.
    MATCH=$(grep -i "slice.*$SLICE_NUM\|S$SLICE_NUM" "$file" 2>/dev/null | head -1)
    if [ -n "$MATCH" ]; then
      echo "Found slice reference in $file:"
      echo "$MATCH"
      # Extract the description after the slice number
      FEATURE_DESC=$(echo "$MATCH" | sed -E "s/.*[Ss]lice.*$SLICE_NUM[:\- ]+(.*)/\1/i" | sed -E "s/.*S$SLICE_NUM[:\- ]+(.*)/\1/i")
      break
    fi
  fi
done

if [ -n "$FEATURE_DESC" ]; then
  echo "Resolved to: $FEATURE_DESC"
else
  echo "No existing slice found - treating as new feature"
  FEATURE_DESC="$ORIGINAL_REQUEST"
fi
```

**Pass the resolved feature description to the job creation step.**

### 4. Create the job

**IMPORTANT**: Before creating the worktree, ensure main branch is up to date:

```bash
git checkout main
git pull origin main
```

Generate a sequential job ID (e.g., `001-add-auth`, `002-rate-limiting`):

```
factory/jobs/<job-id>/
  spec.md
  build.md
  round-1/
    review-security.md
    review-ux.md
    review-ui.md
    review-code.md
  decision.md
```

Update `factory/board.json` (atomic - only touches this job):
```bash
bash factory/board-add-job.sh "<job-id>" "<branch>" "<worktree>"
```

Create a worktree from the up-to-date main branch:
```bash
base_dir="$HOME/.sandbox"
mkdir -p "$base_dir"
git worktree add -b feature/<job-id> "$base_dir/factory-<job-id>" main
```

For bug fixes, use `bug/<job-id>` instead of `feature/<job-id>`.

The worktree path should be:
- `$HOME/.sandbox/factory-<job-id>` (default)
- Or custom path if specified in project context
- Store the worktree path in `board.json` under the `worktree` field

### 5. Spawn spec-writer

Use the Task tool to spawn the `factory-spec-writer` agent with:
- The feature description
- Project context (language, framework, conventions, test command)
- The job directory path
- Instruction to write `factory/jobs/<job-id>/spec.md`

Wait for completion. Atomic update: `bash factory/board-set-stage.sh "<job-id>" "build"`

### 6. Spawn builder

Use the Task tool to spawn the `factory-builder` agent with:
- The spec from `factory/jobs/<job-id>/spec.md`
- Project context
- The job directory path
- The current round number
- The worktree path from board.json
- The branch name from board.json (e.g., `feature/<job-id>` or `bug/<job-id>`)
- Instruction to implement in the worktree directory on the assigned branch, write `factory/jobs/<job-id>/build.md`, commit, and run tests

Wait for completion. Atomic update: `bash factory/board-set-stage.sh "<job-id>" "review"`

### 7. Spawn all 4 reviewers (parallel)

Spawn all four reviewer agents in a single message using the Task tool so they run concurrently:

| Agent | Writes |
|-------|--------|
| `factory-reviewer-security` | `factory/jobs/<job-id>/round-<N>/review-security.md` |
| `factory-reviewer-ux` | `factory/jobs/<job-id>/round-<N>/review-ux.md` |
| `factory-reviewer-ui` | `factory/jobs/<job-id>/round-<N>/review-ui.md` |
| `factory-reviewer-code` | `factory/jobs/<job-id>/round-<N>/review-code.md` |

Each reviewer receives:
- The spec from `spec.md`
- The build notes from `build.md`
- A `git diff` of changes in the worktree vs main (run `git diff main` from the worktree directory)
- Project context
- The worktree path (for file operations if needed)

### 8. WAIT FOR ALL

A review round is done ONLY when all four review files exist in the round folder. Never resume the builder mid-round.

- Read all four review files
- Atomic update for each verdict:
  ```bash
  bash factory/board-set-review.sh "<job-id>" "security" "PASS"
  bash factory/board-set-review.sh "<job-id>" "ux" "CHANGES"
  bash factory/board-set-review.sh "<job-id>" "ui" "PASS"
bash factory/board-set-review.sh "<job-id>" "code" "PASS"
```

### 9. Evaluate reviews

- If ALL verdicts are `PASS` -> go to step 9 (approver)
- If ANY verdict is `CHANGES` and round < 2:
  - Atomic update: `bash factory/board-set-stage.sh "<job-id>" "build" $((N+1))`
  - Create `factory/jobs/<job-id>/round-<N+1>/`
  - Resume the builder (step 5) with the review feedback from the round folder
- If ANY verdict is `CHANGES` and round >= 2:
  - Atomic update: `bash factory/board-set-stage.sh "<job-id>" "needs-human"`
  - Inform the user the job needs manual intervention

### 10. Spawn approver

Use the Task tool to spawn the `factory-approver` agent with:
- The spec, build notes, and all review files
- The `git diff` of the feature branch (from worktree)
- The worktree path
- Instruction to write `factory/jobs/<job-id>/decision.md` starting with `APPROVE` or `ESCALATE`

### 11. Handle decision

- **APPROVE**: 
  1. Navigate to the worktree directory
  2. Fetch latest changes from main: `git fetch origin main`
  3. Check if main has new commits: `git log HEAD..origin/main --oneline`
  4. If main has new commits, rebase the feature branch: `git rebase origin/main`
     - If rebase conflicts occur, resolve them, run tests, and commit
  5. Increment version according to project conventions (e.g., `npm version patch`, update `pyproject.toml`, etc.)
  6. Commit the version bump: `git add -A && git commit -m "chore: bump version to X.Y.Z"`
  7. Push the feature branch: `git push origin <branch-name>`
  8. Navigate to main repo directory
  9. Create a pull request using `gh pr create` with:
     - Title: `<job-id>: <feature name>`
     - Body: Summary from spec.md, list of changes from build.md, and link to job directory
     - Base branch: `main`
     - Head branch: `<branch-name>`
   10. Remove worktree: `git worktree remove "$HOME/.sandbox/factory-<job-id>"`
   11. Optionally delete local branch: `git branch -d <branch-name>`
   12. Atomic update: `bash factory/board-set-pr.sh "<job-id>" "<pr-url>"` (sets stage=done, worktree=null, pr=url)

- **ESCALATE**: Atomic update: `bash factory/board-set-stage.sh "<job-id>" "needs-human"`. Inform the user. Leave worktree intact for manual intervention.

## Branch Checkout Utility

All Factory projects include a `checkout` Makefile target that simplifies switching between feature branches managed by the factory. This is automatically set up during initialization.

### Usage

```bash
# Interactive selection (requires fzf)
make checkout

# Checkout a specific job's branch
make checkout job=001-add-auth

# Checkout main (when no job specified and fzf not available)
make checkout
```

### Behavior

1. **With `fzf` installed**: Shows an interactive menu listing:
   - `main` branch (marked as "default")
   - All active factory jobs with their branch names and current stages
   
2. **Without `fzf` or no job specified**: Falls back to checking out `main`

3. **With job ID specified**: Looks up the job in `factory/board.json`, fetches the associated branch from origin, and checks it out

### Implementation Details

- **Script**: `factory/checkout.sh` - handles all checkout logic
- **Makefile target**: `checkout` - calls the script with optional `job` parameter
- **Dependencies**: `git`, `jq`, optionally `fzf` for interactive mode
- **Error handling**: Validates job exists in `board.json` before attempting checkout

This utility enables developers to quickly switch between factory-managed branches without manually looking up branch names in `board.json`.

## Rules

1. Agents get context from files, not conversation history.
2. Each agent writes ONLY its own file.
3. The orchestrator is the sole writer of `factory/board.json`, and MUST use the atomic helper scripts (`factory/board-*.sh` / `factory/update-board.sh`) for every write. Never read-modify-write the whole file from memory.
4. Each review starts with `VERDICT: PASS` or `VERDICT: CHANGES`.
5. `decision.md` starts with `APPROVE` or `ESCALATE`.
6. The builder works in the assigned worktree directory and tests against the spec's acceptance criteria.
7. Never resume the builder mid-round. Wait for all 4 review files to exist.
8. Maximum 2 review rounds before escalation.
9. Always use worktree paths when running commands or file operations for a job.
10. Clean up worktrees after successful PR creation. Leave worktrees for escalated jobs.
11. Store the absolute worktree path in board.json for consistent access across agents.
12. **CRITICAL**: Always ensure main branch is up to date before creating worktrees (`git pull origin main`).
13. **CRITICAL**: Before opening PR, fetch latest main, rebase feature branch, increment version, then create PR.
14. Use `feature/<job-id>` for new features, `bug/<job-id>` for bug fixes.
15. Store the PR URL in board.json after successful creation.
16. **CRITICAL**: Create `factory/board.json` and all `factory/board-*.sh` helper scripts if they don't exist before creating the first job.
17. **CRITICAL**: Add `factory/jobs/`, `factory/board.json`, and `factory/.board.lock` to `.gitignore` if not already present.
18. **CRITICAL (Concurrent Safety)**: Multiple factory orchestrators may run in parallel. Every `board.json` write MUST go through the helper scripts, which use `flock` on `factory/.board.lock` and scope updates to the current job ID only. Never read the full file, modify in memory, then write it back without locking.
19. **CRITICAL**: When reading `board.json` to get the current state of a job (e.g., to check stage), always re-read it right before use - never cache it across agent spawns.

## Development Methodology Enforced

All agents must follow these constraints (embedded in each agent's instructions):

- **Vertical Slice**: Build feature by feature, each slice contains UI, API, business logic, data access, and schema changes.
- **Branch Management**: Every slice starts on a new branch from an up-to-date main branch. Use `feature/<job-id>` for new features or `bug/<job-id>` for bug fixes. Version incremented only on approval, before PR creation.
- **Pull Request Workflow**: All work ends with a PR opened against main. Main is fetched and rebased before PR creation to ensure no conflicts.
- **Lightweight CQRS**: Separate read operations (Queries) from state-mutating operations (Commands). Never share DTOs between read and write. Commands return minimal state; Queries never mutate.
- **Interface-Driven Boundaries**: Push external I/O to the edges. Core logic relies on injected interfaces for testability.
- **Fail-Fast Validation**: Validate all inputs at the edge of the slice. Reject invalid data immediately.
- **Atomic Execution**: Build slices in isolation. No proactively refactoring shared utilities or global state.
- **Errors as Values**: Handle errors explicitly. No panics for control flow. No silent failures.

## board.json Schema

```json
{
  "jobs": [
    {
      "id": "001-add-auth",
      "branch": "feature/001-add-auth",
      "worktree": "/home/user/.sandbox/factory-001-add-auth",
      "stage": "spec|build|review|needs-human|done",
      "round": 1,
      "reviews": {
        "security": "pending|PASS|CHANGES",
        "ux": "pending|PASS|CHANGES",
        "ui": "pending|PASS|CHANGES",
        "code": "pending|PASS|CHANGES"
      },
      "pr": "https://github.com/owner/repo/pull/123"
    }
  ]
}
```

## backlog.md Format

```markdown
# Backlog

- [ ] Add rate limiting to API endpoints
- [ ] Implement user authentication
- [x] Set up CI pipeline
```

Items marked `[x]` are already completed. `/factory next` picks the first `[ ]` item.

## Git Worktree Management

### Creating Worktrees

**IMPORTANT**: Always ensure main is up to date before creating worktrees:

```bash
# Update main branch first
git checkout main
git pull origin main

# Set up worktree base directory
base_dir="$HOME/.sandbox"
mkdir -p "$base_dir"

# Create worktree with new branch
git worktree add -b feature/<job-id> "$base_dir/factory-<job-id>" main
# Or for bug fixes:
# git worktree add -b bug/<job-id> "$base_dir/factory-<job-id>" main

# Recommended path structure
# Worktrees go to: $HOME/.sandbox/factory-<job-id>
```

### Working in Worktrees

All file operations and commands for a job should use the worktree path:

```bash
# Run tests in worktree
cd "$HOME/.sandbox/factory-<job-id>" && npm test

# Commit changes
cd "$HOME/.sandbox/factory-<job-id>" && git add -A && git commit -m "..."

# Get diff from worktree
git -C "$HOME/.sandbox/factory-<job-id>" diff main
```

### Pre-PR Workflow (Before Merge)

Before opening a PR, the following steps must be completed:

```bash
# Navigate to worktree
cd "$HOME/.sandbox/factory-<job-id>"

# Fetch latest main
git fetch origin main

# Check if main has new commits
git log HEAD..origin/main --oneline

# If main has new commits, rebase
git rebase origin/main
# Resolve any conflicts, run tests, commit

# Increment version (example for npm)
npm version patch --no-git-tag-version
git add -A
git commit -m "chore: bump version to X.Y.Z"

# Push branch
git push origin feature/<job-id>

# Create PR
gh pr create --title "<job-id>: <feature name>" --body "..." --base main --head feature/<job-id>
```

### Cleaning Up Worktrees

```bash
# After successful PR creation
git worktree remove "$HOME/.sandbox/factory-<job-id>"
git branch -d feature/<job-id>

# Force remove if needed (uncommitted changes exist)
git worktree remove --force "$HOME/.sandbox/factory-<job-id>"

# List all worktrees
git worktree list

# Prune stale worktree references
git worktree prune
```

### Worktree Best Practices

1. **Isolation**: Each job gets its own worktree - no sharing between jobs
2. **Path Consistency**: Always use absolute paths stored in board.json
3. **Cleanup**: Remove worktrees immediately after successful merge
4. **Escalation**: Leave worktrees for escalated jobs (needs-human stage)
5. **Disk Space**: Monitor worktree disk usage, especially for large repos
6. **Concurrent Jobs**: Worktrees enable true parallel development on multiple jobs

## Ad-Hoc Feature Resolution Examples

The factory supports two types of feature requests:

### Example 1: Referencing an existing slice

**User request:** `/factory Implement Slice 19`

**Factory behavior:**
1. Searches for planning files (plan.md, todo.md, slices.md, etc.)
2. Finds in `plan.md`:
   ```markdown
   ## Slice 19: Add user authentication
   - Implement JWT-based auth
   - Add login/logout endpoints
   - Secure protected routes
   ```
3. Extracts the description: "Add user authentication - Implement JWT-based auth, Add login/logout endpoints, Secure protected routes"
4. Creates job with this resolved description
5. Proceeds through the normal factory loop

### Example 2: Creating a new feature

**User request:** `/factory Implement dark mode`

**Factory behavior:**
1. Searches for planning files
2. Searches for existing references to "dark mode" in planning files
3. If not found, treats "dark mode" as a new feature description
4. Creates job with "dark mode" as the feature description
5. Proceeds through the normal factory loop

### Example 3: Referencing an existing feature in backlog

**User request:** `/factory Implement rate limiting`

**Factory behavior:**
1. Searches for planning files
2. Finds in `todo.md`:
   ```markdown
   - [ ] Add rate limiting to API endpoints
   ```
3. Uses the existing description: "Add rate limiting to API endpoints"
4. Creates job and proceeds through the factory loop
