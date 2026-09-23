# Neovim Configuration

## Required: Nerd Font

This configuration uses Nerd Font glyphs for icons (statusline, tabline, file explorer, completion, markdown preview). **Without a Nerd Font installed, icons will not display.**

Install one of the [Nerd Fonts](https://www.nerdfonts.com/) and set it as your terminal font. Recommended: **JetBrainsMono Nerd Font** (matches the `guifont` set in `lua/options.lua`).

### Airgapped installation

Download the font archive from your mirror (releases are on GitHub, so route through your GitHub mirror or artifactory) and install to the user font directory:

```bash
# Replace the URL with your mirror path
curl -L "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/JetBrainsMono.zip" -o /tmp/JetBrainsMono.zip
mkdir -p ~/.local/share/fonts
unzip -o /tmp/JetBrainsMono.zip -d ~/.local/share/fonts/JetBrainsMonoNerdFont
fc-cache -fv
```

Then set the font in your terminal emulator:
- **GNOME Terminal / Tilix**: Preferences -> Profile -> Custom font -> `JetBrainsMono Nerd Font Mono`
- **kitty**: `font_family JetBrainsMono Nerd Font Mono` in `kitty.conf`
- **alacritty**: `font.family = "JetBrainsMono Nerd Font Mono"` in `alacritty.yml`/`alacritty.toml`
- **VS Code**: in settings.json set `"terminal.integrated.fontFamily": "JetBrainsMono Nerd Font Mono"` (and optionally `"editor.fontFamily"`), then restart VS Code
- **Windows Terminal**: Settings -> Profiles -> Appearance -> Font face -> `JetBrainsMono Nerd Font Mono`
- **tmux**: `set -g default-terminal "tmux-256color"` and ensure the terminal itself has the Nerd Font

Verify the font is installed: `fc-list | grep -i nerd`

## Airgapped / Offline Setup

This configuration supports airgapped environments via environment variables.

### Plugin Mirror (GitHub)

Set these before launching nvim to pull plugins from a local mirror instead of github.com:

```bash
export NVIM_AIRGAPPED=1
export NVIM_GITHUB_MIRROR_URL="https://artifactory.internal.example.com/github-proxy/"
```

The URL must end with `/` and serve as a drop-in replacement for `https://github.com/`.

### Mason Registry Mirror

Mason installs LSP servers, linters, and formatters. To use a custom registry:

```bash
export MASON_REGISTRY_MIRROR="https://artifactory.internal.example.com/mason-registry"
```

Alternatively, create `lua/local/mason.lua` in this config directory to pass arbitrary options to `require("mason").setup()`.

## External Dependencies

### LSP Servers (via Mason)

All LSP servers are installed through Mason. Run `:MasonToolsInstall` (or `<leader>Mi`) to install them.

| Language   | LSP Server       | Mason Package    |
|------------|------------------|------------------|
| Go         | gopls            | `gopls`          |
| Python     | basedpyright     | `basedpyright`   |
| Bash       | bashls           | `bashls`         |
| YAML       | yamlls           | `yamlls`         |
| JSON       | jsonls           | `jsonls`         |
| JS/TS/React| ts_ls            | `ts_ls`          |
| Lua        | lua_ls           | `lua_ls`         |
| Markdown   | marksman         | `marksman`       |
| Spellcheck | typos_lsp        | `typos_lsp`      |

### Linters (via Mason + nvim-lint)

| Language   | Linter           | Mason Package    |
|------------|------------------|------------------|
| Go         | golangci-lint    | `golangci-lint`  |
| Python     | ruff             | `ruff`           |
| Bash/Shell | shellcheck       | `shellcheck`     |
| YAML       | yamllint         | `yamllint`       |
| JSON       | jsonlint         | `jsonlint`       |
| Markdown   | markdownlint     | `markdownlint`   |
| JS/TS/React| oxlint           | `oxlint`         |
| Proto      | buf_lint         | _(not in mason)_ |

### Formatters (via Mason + conform.nvim)

| Language   | Formatter        | Mason Package    |
|------------|------------------|------------------|
| Bash/Shell | shfmt            | `shfmt`          |
| Go         | goimports/go fmt | _(ships with Go)_|
| Python     | ruff (format)    | `ruff`           |
| YAML       | yamlfmt          | `yamlfmt`        |
| JSON       | prettier         | `prettier`       |
| JS/TS/React| prettier         | `prettier`       |
| Markdown   | prettier         | `prettier`       |

### System Dependencies (not managed by Mason)

- **Go**: `gopls` and `golangci-lint` require Go installed (`/usr/local/go/bin` in PATH)
- **Python**: `basedpyright` and `ruff` require Python 3.x
- **Node.js**: `prettier`, `jsonlint`, `markdownlint`, `oxlint`, `ts_ls` require Node.js runtime
- **Shell**: `shellcheck` and `shfmt` are standalone binaries

## Enabling LSP per Filetype

LSP servers attach automatically when opening a file of the matching type. If a server is not installed, open Mason (`:Mason` or `<leader>Mm`) and install it, or run `<leader>ML` to install the LSP for the current buffer.

## Formatting

**Auto-format on save** is enabled. Saving a file (`:w`) will format it using the configured formatter. If no formatter is available, it falls back to the LSP's formatting.

**Manual formatting**: Press `<leader>cf` in normal or visual mode to format the buffer or selection.

## Opening Files

**Fuzzy finder** (fzf-lua):
- `F` or `<leader>ff` - Search and open files (opens in current buffer/window)
- `<leader>fg` - Live grep (search file contents)
- `<leader>fb` - Switch between open buffers

**Workflow for splits**:
1. Create a split: `<leader>bh` (horizontal) or `<leader>bv` (vertical)
2. Open a file in that split: `F` or `<leader>ff`

**File explorer** (neo-tree):
- `<leader>e` - Toggle file explorer
- Navigate with `j`/`k`, open with `<CR>`, open in split with `s` (horizontal) or `v` (vertical)

**Direct commands**:
- `:e <path>` - Edit file in current buffer
- `:sp <path>` - Edit file in horizontal split
- `:vsp <path>` - Edit file in vertical split

## Keymaps

| Key | Action |
|-----|--------|
| `<leader>e` | Toggle file explorer (neo-tree) |
| `<leader>fed` | Show diagnostics tree (float) |
| `<leader>feg` | Show git status tree (float) |
| `<leader>tm` | Toggle minimap |
| `<leader>gS` | Toggle split/join (single/multi-line) |
| `<leader>gg` | Go to definition |
| `<leader>th` | Toggle inlay hints |
| `<leader>cf` | Format buffer (conform) |
| `<leader>ll` | Run linter manually |
| `<leader>pu` | Update plugins |
| `<leader>pl` | List/check plugins (offline) |
| `<leader>pd` | Delete inactive plugins |
| `<leader>pf` | Force update plugins (no confirm) |
| `<leader>pr` | Revert plugins to lockfile |
| `<leader>Mm` | Open Mason UI |
| `<leader>Mi` | Install all mason tools |
| `<leader>Mu` | Update mason tools |
| `<leader>Mc` | Clean unused mason tools |
| `<leader>Mr` | Refresh mason registry |
| `<leader>ML` | Install LSP server for current buffer |
| `<Tab>` / `<S-Tab>` | Next / previous buffer |
| `<leader>bd` | Delete buffer |
| `<leader>bn` | New empty buffer |
| `<leader>bh` | New horizontal split buffer |
| `<leader>bv` | New vertical split buffer |
| `<leader>r` | Reload Neovim config |
