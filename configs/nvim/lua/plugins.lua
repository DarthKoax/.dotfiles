local is_airgapped = vim.fn.getenv("NVIM_AIRGAPPED") == "1"
local base_url = is_airgapped and vim.fn.getenv("NVIM_GITHUB_MIRROR_URL") or "https://github.com/"

-- Helper function to keep the list clean
local function plugin(repo_path, opts)
    opts = opts or {}
    opts.src = base_url .. repo_path
    return opts
end

vim.pack.add({
	plugin("nvim-mini/mini.nvim"),
	plugin("nvim-lua/plenary.nvim"),
	plugin("MunifTanjim/nui.nvim"),
	plugin("nvim-tree/nvim-web-devicons"),
	plugin("nvim-neo-tree/neo-tree.nvim"),
	plugin("mrbjarksen/neo-tree-diagnostics.nvim"),
	plugin("folke/which-key.nvim"),
	-- plugin("rmagatti/auto-session"),
	plugin("ibhagwan/fzf-lua"),
	-- plugin("rachartier/tiny-code-action.nvim"),
	-- plugin("smjonas/inc-rename.nvim"),
	-- plugin("TheNoeTrevino/haunt.nvim"),
	-- plugin("lewis6991/gitsigns.nvim"),
	-- plugin("sainnhe/gruvbox-material"),
	-- plugin("webhooked/kanso.nvim"),
	-- plugin("romus204/tree-sitter-manager.nvim"),
	plugin("saghen/blink.cmp", { version = vim.version.range("1.*") }),
	plugin("stevearc/conform.nvim"),
	plugin("mfussenegger/nvim-lint"),
 	plugin("mason-org/mason.nvim"),
	plugin("mason-org/mason-lspconfig.nvim"),
	plugin("WhoIsSethDaniel/mason-tool-installer.nvim"),
	-- plugin("mfussenegger/nvim-dap"),
	-- plugin("jay-babu/mason-nvim-dap.nvim"),
	-- plugin("mfussenegger/nvim-dap-python"),
	-- plugin("leoluz/nvim-dap-go"),
	-- plugin("igorlfs/nvim-dap-view"),
	plugin("neovim/nvim-lspconfig"),
	-- plugin("qvalentin/helm-ls.nvim"),
	-- plugin("mfussenegger/nvim- jdtls"),
	plugin("rachartier/tiny-cmdline.nvim"),
	-- plugin("windwp/nvim-ts-autotag"),
	plugin("OXY2DEV/markview.nvim"),
	-- plugin("nvim-treesitter/nvim-treesitter-context"),
	-- -- nvim-dap-ui (alternative to nvim-dap-view)
	-- plugin("nvim-neotest/nvim-nio"),
	-- plugin("rcarriga/nvim-dap-ui"),
})

local plugin_modules = {
	"plugins.mini",
	"plugins.which_key",
	-- "plugins.auto_session",
	"plugins.neo_tree",
	"plugins.fzf",
	-- "plugins.tiny_code_action",
	-- "plugins.inc_rename",
	-- "plugins.haunt",
	-- "plugins.gitsigns",
	-- "plugins.treesitter",
	-- "plugins.helm",
	"plugins.blink",
	"plugins.conform",
	"plugins.lint",
	"plugins.mason",
	-- "plugins.dap",
	-- "plugins.jdtls",
	"plugins.lsp",
	"plugins.tiny_cmdline",
	-- "plugins.autotag",
        "plugins.markview",
	-- "plugins.treesitter_context",
	-- "plugins.atlas",
}

for _, module in ipairs(plugin_modules) do
	require(module)
end
