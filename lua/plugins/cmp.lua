return {
	-- Плагин автодополнения
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			-- Источники для nvim-cmp
			{ "hrsh7th/cmp-nvim-lsp" }, -- LSP источник
			{ "hrsh7th/cmp-buffer" }, -- Источник из буфера
			{ "hrsh7th/cmp-path" }, -- Источник для автодополнения пути
			{ "hrsh7th/cmp-cmdline" }, -- Источник для командной строки
			{ "saadparwaiz1/cmp_luasnip" }, -- Поддержка LuaSnip
			{ "L3MON4D3/LuaSnip" }, -- Движок сниппетов LuaSnip
			{ "rafamadriz/friendly-snippets" }, -- Готовые сниппеты для различных языков
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")

			-- Загрузка сниппетов
			require("luasnip.loaders.from_vscode").lazy_load()

			cmp.setup({
				snippet = {
          expand = function(args)
            if luasnip.expandable() then
                luasnip.expand(args.body)
            else
                luasnip.lsp_expand(args.body) -- Используем LuaSnip для расширения сниппетов
            end
          end,
				},
				window = {
					-- completion = cmp.config.window.bordered(),  -- Можно включить границы для окон автодополнения
					-- documentation = cmp.config.window.bordered(),
				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,  -- Добавь эту строку
            select = true,
          }),
					["<Tab>"] = cmp.mapping(function(fallback)
            if luasnip.expandable() then
              luasnip.expand()
            elseif cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" }, -- LSP источник
					{ name = "luasnip" }, -- Источник для LuaSnip
				}, {
					{ name = "buffer" }, -- Источник из буфера
					{ name = "path" }, -- Источник для автодополнения пути
				}),
			})

			-- Настройка для автодополнения в командной строке (например, для : и /)
			cmp.setup.cmdline({ "/", "?" }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			})

			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{ name = "cmdline" },
				}),
			})
		end,
	},
}
