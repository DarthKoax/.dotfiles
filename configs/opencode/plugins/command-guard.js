// ~/.config/opencode/plugins/command-guard.js

const RULES = [
  // 1. ALLOW: Exact commands or commands with arguments
  { pattern: /^(touch|ls|pwd|cat|git status|git diff)(\s+.*)?$/, action: 'allow' },

  // 2. DENY: Explicitly prohibited actions
  { pattern: /^rm\s+-rf\s+.*$/, action: 'deny' },

  // 3. ASK: Destructive, modifying, or untrusted execution
  { pattern: /^rm\s+.*$/, action: 'ask' },
  { pattern: /^git push.*/, action: 'ask' }
];

function evaluateCommand(command) {
  const trimmed = command.trim();
  for (const rule of RULES) {
    if (rule.pattern.test(trimmed)) {
      return rule.action;
    }
  }
  return 'ask'; // Default policy for unknown commands
}

export default async function CommandGuardPlugin(ctx) {
  return {
    hooks: {
      async onPreToolExecute(toolCtx) {
        // Intercept standard shell tools (bash, execute_command, terminal)
        const isShellTool = ['bash', 'execute_command', 'shell', 'terminal'].includes(toolCtx.toolName);
        if (!isShellTool) return;

        const command = toolCtx.args?.command || toolCtx.args?.cmd;
        if (!command) return;

        const action = evaluateCommand(command);

        // --- ACTION 1: DENY ---
        if (action === 'deny') {
          throw new Error(`[SECURITY DENIED]: The command '${command}' is blocked by policy.`);
        }

        // --- ACTION 2: ASK ---
        if (action === 'ask') {
          let approved = false;

          // Try native TUI prompt if available in context
          if (ctx.client?.confirm) {
            approved = await ctx.client.confirm({
              title: "Security Approval",
              message: `Agent wants to run:\n  ${command}`
            });
          } else {
            // Hard fallback if TUI confirmation isn't available:
            // Fail fast so OpenCode asks in chat instead of bypassing permission!
            throw new Error(`[PERMISSION REQUIRED]: The command '${command}' requires manual approval. Ask the user in chat before proceeding.`);
          }

          if (!approved) {
            throw new Error(`[USER REJECTED]: Execution of '${command}' was denied by user.`);
          }
        }

        // --- ACTION 3: ALLOW ---
        // Do nothing, execution proceeds
      }
    }
  };
}