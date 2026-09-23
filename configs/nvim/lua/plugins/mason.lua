

local map = vim.keymap.set

local M = {}

M.lsp_servers = {
	"gopls",
	"lua_ls",
	"basedpyright",
	"bashls",
	"yamlls",
	"jsonls",
	"ts_ls",
	"marksman",
	"typos_lsp",
	"helm_ls",
}

M.lsp_and_tools = {
	"gopls",
	"lua_ls",
	"basedpyright",
	"bashls",
	"yamlls",
	"jsonls",
	"ts_ls",
	"marksman",
	"typos_lsp",
	"shellcheck",
	"golangci-lint",
	"helm-ls",
	"yq",
	"markdownlint",
	"yamllint",
	"jsonlint",
	"oxlint",
	"shfmt",
	"ruff",
	"yamlfmt",
	"prettier",
}



local mason_opts = {}

pcall(function()
	mason_opts = require("local.mason")
end)

local registry = vim.env.MASON_REGISTRY_MIRROR
if registry then
	mason_opts.registries = { registry }
end

require("mason").setup(mason_opts)

require("mason-lspconfig").setup({
	automatic_enable = true,
})

require("mason-tool-installer").setup({
	ensure_installed = vim.list_extend(M.lsp_and_tools, {}),
	auto_update = false,
	run_on_start = false,
})

map("n", "<leader>Mm", "<cmd>Mason<CR>", { desc = "Mason UI" })
map("n", "<leader>Mi", "<cmd>MasonToolsInstall<CR>", { desc = "Install Mason Tools" })
map("n", "<leader>Mu", "<cmd>MasonToolsUpdate<CR>", { desc = "Update Mason Tools" })
map("n", "<leader>Mc", "<cmd>MasonToolsClean<CR>", { desc = "Clean Mason Tools" })
map("n", "<leader>Mr", "<cmd>MasonUpdate<CR>", { desc = "Refresh Mason Registry" })
map("n", "<leader>Ml", "<cmd>MasonLog<CR>", { desc = "Mason Log" })
map("n", "<leader>ML", "<cmd>LspInstall<CR>", { desc = "Install LSP For Buffer" })

return M
