require("gabivlj.set")
require("gabivlj.remap")

require("gabivlj.lazy_init")

-- DO.not
-- DO NOT INCLUDE THIS

-- If i want to keep doing lsp debugging
-- function restart_htmx_lsp()
--     require("lsp-debug-tools").restart({ expected = {}, name = "htmx-lsp", cmd = { "htmx-lsp", "--level", "DEBUG" }, root_dir = vim.loop.cwd(), });
-- end

-- DO NOT INCLUDE THIS
-- DO.not

local augroup = vim.api.nvim_create_augroup
local ThePrimeagenGroup = augroup("ThePrimeagen", {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup("HighlightYank", {})
function R(name)
	require("plenary.reload").reload_module(name)
end

vim.filetype.add({
	extension = {
		templ = "templ",
	},
})

autocmd("TextYankPost", {
	group = yank_group,
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({
			higroup = "IncSearch",
			timeout = 40,
		})
	end,
})

autocmd({ "BufWritePre" }, {
	group = ThePrimeagenGroup,
	pattern = "*",
	command = [[%s/\s\+$//e]],
})

autocmd("LspAttach", {
	group = ThePrimeagenGroup,
	callback = function(e)
		local opts = { buffer = e.buf }
		vim.keymap.set("n", "gd", function()
			vim.lsp.buf.definition()
		end, opts)
		vim.keymap.set("n", "K", function()
			vim.lsp.buf.hover()
		end, opts)
		vim.keymap.set("n", "<leader>vws", function()
			vim.lsp.buf.workspace_symbol()
		end, opts)
		vim.keymap.set("n", "<leader>vd", function()
			vim.diagnostic.open_float()
		end, opts)
		vim.keymap.set("n", "<leader>vca", function()
			vim.lsp.buf.code_action()
		end, opts)
		vim.keymap.set("n", "<leader>vrr", function()
			vim.lsp.buf.references()
		end, opts)
		vim.keymap.set("n", "<leader>vrn", function()
			vim.lsp.buf.rename()
		end, opts)
		vim.keymap.set("i", "<C-h>", function()
			vim.lsp.buf.signature_help()
		end, opts)
		vim.keymap.set("n", "[d", function()
			vim.diagnostic.goto_next()
		end, opts)
		vim.keymap.set("n", "]d", function()
			vim.diagnostic.goto_prev()
		end, opts)
	end,
})

require("lsp-format").setup({})

local on_attach = function(client, bufnr)
	require("lsp-format").on_attach(client, bufnr)
end

require("Comment").setup({
	post_hook = function(ctx)
		if ctx.ctype == 1 then
			-- Only move the cursor in normal mode (not in visual mode)
			-- Get the current line and cursor position
			local cursor_pos = vim.api.nvim_win_get_cursor(0)
			local line = vim.api.nvim_get_current_line()

			-- Find the position of the first non-whitespace character after the comment leader
			local comment_start = line:find("%S", 1)
			if comment_start then
				vim.api.nvim_win_set_cursor(0, { cursor_pos[1], comment_start + 1 })
			end
		end
	end,
})

require("lspconfig").gopls.setup({ on_attach = on_attach })
require("lspconfig").rust_analyzer.setup({ on_attach = on_attach })

local util = require("formatter.util")

local prettier = function()
	return {
		exe = "prettierd",
		args = {
			util.escape_path(util.get_current_buffer_file_path()),
		},
		stdin = true,
	}
end
local black = { exe = "black", args = { "-" }, stdin = true }
local clang_format = { exe = "clang-format", args = {}, stdin = true }
local stylua = { exe = "stylua", args = { "--indent-width", "2", "-" }, stdin = true }

require("formatter").setup({
	filetype = {
		javascript = { prettier },
		typescript = { prettier },
		python = { black },
		c = { clang_format },
		lua = { stylua },
		-- Add more filetypes and corresponding formatters as needed
	},
})

augroup("__formatter__", { clear = true })
autocmd("BufWritePost", {
	group = "__formatter__",
	command = ":FormatWrite",
})

-- leader f/F to format/format-write
vim.api.nvim_set_keymap("n", "<leader>f", "<cmd>Format<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>F", "<cmd>FormatWrite<CR>", { noremap = true, silent = true })

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

-- I am so sorry, but i need this.
vim.api.nvim_set_keymap("i", "<A-BS>", "<C-w>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("v", "<S-Tab>", "<gv", { noremap = true, silent = true })

vim.api.nvim_set_keymap("v", "<Tab>", ">gv", { noremap = true, silent = true })

autocmd("FileType", {
	pattern = "typescript",
	callback = function()
		vim.opt_local.shiftwidth = 2
		vim.opt_local.tabstop = 2
		vim.opt_local.expandtab = true
	end,
})
