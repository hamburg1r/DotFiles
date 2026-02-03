{ ... }: {
	programs.nixvim.plugins.cmp = {
		enable = false;
		settings = {
		preselect = "Item";
		cmdline.completion.completeopt = "menu,menuone,noinsert";
		mapping = let
			luasnip = "require('luasnip')";
		in {
			"<C-Space>" = "cmp.mapping.complete()";
			"<C-c>" = "cmp.mapping.close()";
			"<C-d>" = "cmp.mapping.scroll_docs(1)";
			"<C-u>" = "cmp.mapping.scroll_docs(-1)";
			"<CR>" = "cmp.mapping.confirm({ select = true })";
			"<S-Tab>" = ''
				function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					-- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable() 
					-- that way you will only jump inside the snippet region
					elseif ${luasnip}.jumpable(-1) then
						${luasnip}.jump(-1)
					else
						fallback()
					end
				end,
				{"i", "s"}
				'';
			"<Tab>" = ''
				function(fallback)
					local has_words_before = function()
						unpack = unpack or table.unpack
						local line, col = unpack(vim.api.nvim_win_get_cursor(0))
						return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
					end
					if cmp.visible() then
						cmp.select_next_item()
					-- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable() 
					-- that way you will only jump inside the snippet region
					elseif ${luasnip}.expand_or_locally_jumpable() then
						${luasnip}.expand_or_jump()
					elseif has_words_before() then
						cmp.complete()
					else
						fallback()
					end
				end,
				{"i", "s"}
			'';
		};
		snippet.expand = "luasnip";
		sources = [
			{ name = "nvim_lsp"; }
			{ name = "luasnip"; }
			{ name = "fuzzy_path"; }
			{ name = "path"; }
			{ name = "fuzzy_buffer"; }
			{ name = "buffer"; }
			{ name = "calc"; }
			{ name = "spell"; }
			{ name = "nvim_lsp_signature_help"; }
		];
		};
	};
	programs.nixvim.extraConfigLuaPost = ''
		-- If you want insert `(` after select function or method item
		local cmp_autopairs = require('nvim-autopairs.completion.cmp')
		local cmp = require('cmp')
		cmp.event:on(
			'confirm_done',
			cmp_autopairs.on_confirm_done()
		)
	'';
}
