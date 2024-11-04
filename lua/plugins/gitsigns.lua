return {
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require('gitsigns').setup({
        signcolumn = true,
        current_line_blame = true,  -- включение показа blame на текущей строке
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = 'eol',  -- позиция текста (в конце строки)
          delay = 1000,           -- задержка перед показом (в миллисекундах)
        },
        current_line_blame_formatter = '<author>, <author_time:%d-%m-%Y> - <summary>', -- формат вывода
      })
		end
	}
}
