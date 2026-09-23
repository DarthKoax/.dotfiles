local conform = require("conform")

conform.setup({
	formatters_by_ft = {
		bash = { "shfmt" },
		sh = { "shfmt" },
		go = { "goimports", "gofmt" },
		python = { "ruff_format" },
		yaml = { "yamlfmt" },
		json = { "prettier" },
		javascript = { "prettier" },
		javascriptreact = { "prettier" },
		typescript = { "prettier" },
		typescriptreact = { "prettier" },
		markdown = { "prettier" },
	},
	format_on_save = {
		timeout_ms = 2000,
		lsp_format = "fallback",
	},
})

vim.keymap.set({ "n", "v" }, "<leader>cf", function()
	conform.format({
		lsp_format = "fallback",
		timeout_ms = 2000,
	})
end, { desc = "Format Buffer" })
