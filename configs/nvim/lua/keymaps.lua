local map = vim.keymap.set

vim.g.mapleader = " "

vim.opt.expandtab = true   -- Convert tabs to spaces
vim.opt.tabstop = 4        -- Insert 4 spaces for a tab
vim.opt.shiftwidth = 4     -- Change the number of spaces inserted for indentation
vim.opt.softtabstop = 4    -- Makes the spaces feel like a real tab when deleting

-- Open a new empty buffer using Leader + b + n
vim.keymap.set("n", "<leader>bn", "<cmd>enew<cr>", { desc = "New Empty Buffer" })

-- Open a new buffer in a horizontal split window
vim.keymap.set("n", "<leader>bh", "<cmd>new<cr>", { desc = "New Buffer Horizontal Split" })

-- Open a new buffer in a vertical split window
vim.keymap.set("n", "<leader>bv", "<cmd>vnew<cr>", { desc = "New Buffer Vertical Split" })

-- Move to the next buffer
vim.keymap.set("n", "<Tab>", "<cmd>bnext<cr>", { desc = "Next Buffer" })

-- Move to the previous buffer
vim.keymap.set("n", "<S-Tab>", "<cmd>bprevious<cr>", { desc = "Previous Buffer" })

-- Close (delete) the current buffer without closing Neovim
vim.keymap.set("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Delete Buffer" })

map("n", "<leader>pu", function()
	vim.pack.update()
end, { desc = "Update Plugins" })


-- Create a user command to reload the config
vim.api.nvim_create_user_command("ReloadConfig", function()
    -- Change "user" to the name of your base configuration folder if different
    for name, _ in pairs(package.loaded) do
        if name:match("^user") or name:match("^plugins") then
            package.loaded[name] = nil
        end
    end

    dofile(vim.env.MYVIMRC)
    vim.notify("Neovim configuration reloaded!", vim.log.levels.INFO)
end, {})

-- Optional: Map it to a key (e.g., <leader>r)
vim.keymap.set("n", "<leader>r", ":ReloadConfig<CR>", { silent = true })

-- -- -- General neovim keymaps
-- map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear Search Highlight" })

-- map("n", "<C-h>", "<C-w>h", { desc = "Window Left" })
-- map("n", "<C-j>", "<C-w>j", { desc = "Window Down" })
-- map("n", "<C-k>", "<C-w>k", { desc = "Window Up" })
-- map("n", "<C-l>", "<C-w>l", { desc = "Window Right" })

-- map("n", "<S-h>", "<cmd>bprevious<CR>", { desc = "Previous Buffer" })
-- map("n", "<S-l>", "<cmd>bnext<CR>", { desc = "Next Buffer" })
-- local function delete_buffers(except_current)
-- 	local current = vim.api.nvim_get_current_buf()
-- 	local buffers = {}
-- 	local skipped = 0

-- 	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
-- 		if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].buflisted and not (except_current and buf == current) then
-- 			if vim.bo[buf].buftype == "terminal" then
-- 				skipped = skipped + 1
-- 			elseif buf == current then
-- 				table.insert(buffers, buf)
-- 			else
-- 				table.insert(buffers, 1, buf)
-- 			end
-- 		end
-- 	end

-- 	for _, buf in ipairs(buffers) do
-- 		local ok = pcall(vim.api.nvim_buf_delete, buf, {})
-- 		if not ok then
-- 			skipped = skipped + 1
-- 		end
-- 	end

-- 	if skipped > 0 then
-- 		vim.notify("Skipped " .. skipped .. " protected buffer(s)", vim.log.levels.INFO)
-- 	end
-- end

-- map("n", "<leader>bdd", "<cmd>bdelete<CR>", { desc = "Delete Buffer" })
-- map("n", "<leader>bda", "<cmd>%bd<CR>", { desc = "Delete All Buffers" })
-- map("n", "<leader>bdo", "<cmd>%bd|e#|bd! #<CR>", { desc = "Delete Other Buffers" })
-- map("n", "<leader>bdA", "<cmd>%bd!<CR>", { desc = "Force Delete All Buffers" })
-- map("n", "<leader>bdO", "<cmd>%bd!|e#|bd! #<CR>", { desc = "Force Delete Other Buffers" })

-- map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })



map("n", "<leader>pl", function()
	vim.pack.update(nil, { offline = true })
end, { desc = "List/Check Plugins" })

map("n", "<leader>pd", function()
	local inactive = vim.iter(vim.pack.get())
		:filter(function(plugin)
			return not plugin.active
		end)
		:map(function(plugin)
			return plugin.spec.name
		end)
		:totable()

	if #inactive == 0 then
		vim.notify("No inactive plugins to delete", vim.log.levels.INFO)
		return
	end

	vim.ui.select({ "Delete", "Cancel" }, {
		prompt = "Delete inactive plugins: " .. table.concat(inactive, ", ") .. "?",
	}, function(choice)
		if choice == "Delete" then
			vim.pack.del(inactive)
		end
	end)
end, { desc = "Delete Inactive Plugins" })

map("n", "<leader>pf", function()
	vim.pack.update(nil, { force = true })
end, { desc = "Force Update Plugins" })

map("n", "<leader>pr", function()
	vim.pack.update(nil, { target = "lockfile" })
end, { desc = "Revert Plugins to Lockfile" })

-- -- -- Folds
-- map("n", "<leader>z", "za", { desc = "Toggle Fold" })
-- map("n", "<leader>Z", "zA", { desc = "Toggle Fold Recursive" })
-- map("n", "zR", "zR", { desc = "Open All Folds" })
-- map("n", "zM", "zM", { desc = "Close All Folds" })

-- -- -- Blackhole registers, delete without affecting copy buffer
-- -- map("v", "<leader>dd", '"_d', { desc = "Delete Without Yank" })
-- -- map("v", "<leader>dc", '"_c', { desc = "Change Without Yank" })
-- -- map("n", "x", '"_x', { desc = "Delete Char Without Yank" })
-- -- map("v", "p", '"_dP', { desc = "Paste Without Yank Replace" })
