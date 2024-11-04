-- Line numbers
vim.wo.number = true
vim.wo.relativenumber = true

-- Mouse
vim.opt.mouse = "a"
vim.opt.mousefocus = true

-- Clipboard
vim.opt.clipboard = "unnamedplus"

-- Indent Settings
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2

-- Other
vim.opt.scrolloff = 8
vim.opt.wrap = false
vim.opt.termguicolors = true
vim.o.signcolumn = "yes"

-- Fillchars
vim.opt.fillchars = {
	vert = "│",
	fold = "⠀",
	eob = " ", -- suppress ~ at EndOfBuffer
	-- diff = "⣿", -- alternatives = ⣿ ░ ─ ╱
	msgsep = "‾",
	foldopen = "▾",
	foldsep = "│",
	foldclose = "▸",
}

-- .jet handling
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "*.jet",
	command = "set filetype=html",
})
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*.jet",
	callback = function()
		vim.lsp.buf.format({ async = false })
	end,
})


vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	pattern = "*.go",
	callback = function()
		vim.lsp.buf.format({ timeout_ms = 3000 })
	end,
})

local TrimWhiteSpaceGrp = vim.api.nvim_create_augroup("TrimWhiteSpaceGrp", {})
vim.api.nvim_create_autocmd("BufWritePre", {
	group = TrimWhiteSpaceGrp,
	pattern = "*",
	command = "%s/\\s\\+$//e",
})

local YankHighlightGrp = vim.api.nvim_create_augroup("YankHighlightGrp", {})
vim.api.nvim_create_autocmd("TextYankPost", {
	group = YankHighlightGrp,
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({
			higroup = "IncSearch",
			timeout = 40,
		})
	end,
})

vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
  pattern = "Podfile",
  callback = function()
    vim.bo.filetype = "ruby"
  end,
})

-- vim.cmd([[
--   autocmd BufWinEnter *.go GoToggleInlay
-- ]])