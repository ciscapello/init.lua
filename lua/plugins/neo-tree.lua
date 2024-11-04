return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
		-- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
	},
	config = function()
		vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none", fg = "none" })
		vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none", fg = "none" })
    vim.api.nvim_set_hl(0, 'NeoTreeGitAdded', { fg = '#00ff00' })  -- Добавленные файлы
    -- Цвет для измененных файлов
    vim.api.nvim_set_hl(0, 'NeoTreeGitModified', { fg = '#ff8800' })  -- Измененные файлы
    -- Цвет для удаленных файлов
    vim.api.nvim_set_hl(0, 'NeoTreeGitDeleted', { fg = '#ff0000' })  -- Удаленные файлы
    -- Цвет для неотслеживаемых файлов
    vim.api.nvim_set_hl(0, 'NeoTreeGitUntracked', { fg = '#ff00ff' })  -- Неотслеживаемые файлы)
		vim.diagnostic.config({
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = " ",
					[vim.diagnostic.severity.WARN] = " ",
					[vim.diagnostic.severity.INFO] = " ",
					[vim.diagnostic.severity.HINT] = " ",
				},
			},
		})
		require("neo-tree").setup({
			close_if_last_window = false,
			filesystem = {
				filtered_items = {
					hide_dotfiles = false, -- Показ скрытых файлов
				},
				follow_current_file = {
					enabled = true, -- This will find and focus the file in the active buffer every time
					--               -- the current file is changed while the tree is open.
					leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
				},
			},
			window = {
				mappings = {
					["z"] = "close_all_nodes", -- Назначает клавишу 'z' для сворачивания всех узлов
          ["gy"] = function(state)
            local node = state.tree:get_node()
            local filepath = node.path
            vim.fn.setreg('+', filepath)
            print("Скопирован путь: " .. filepath)
          end,        },
			},
		})
	end,
}
