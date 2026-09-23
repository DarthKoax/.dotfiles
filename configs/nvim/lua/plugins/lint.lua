local map = vim.keymap.set
local lint = require("lint")

lint.linters_by_ft = {
	go = { "golangcilint" },
	python = { "ruff" },
	sh = { "shellcheck" },
	bash = { "shellcheck" },
	yaml = { "yamllint" },
	json = { "jsonlint" },
	markdown = { "markdownlint" },
	proto = { "buf_lint" },
	javascript = { "oxlint" },
	javascriptreact = { "oxlint" },
	typescript = { "oxlint" },
	typescriptreact = { "oxlint" },
}

map("n", "<leader>ll", function()
	lint.try_lint()
end, { desc = "Run Lint" })

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	callback = function()
		lint.try_lint()
	end,
})
