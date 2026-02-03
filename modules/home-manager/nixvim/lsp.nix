{ pkgs, ... }: {
	# TODO: checkout
	# dropbar.nvim https://github.com/Bekaboo/dropbar.nvim
	programs.nixvim.plugins.emmet = {
		enable = true;
	};
	programs.nixvim.plugins.lsp = {
		enable = true;
		keymaps.lspBuf = {
			K = "hover";
			gD = "references";
			gd = "definition";
			gi = "implementation";
			gt = "type_definition";
		};
		onAttach = ''
		if client.server_capabilities.documentSymbolProvider then
			require("nvim-navic").attach(client, bufnr)
		end
		'';
		servers = {
			bashls.enable = true;
			html.enable = true;
			lua-ls.enable = true;
			nixd.enable = true;
			# pylsp.enable = true;
			# ruff-lsp.enable = true;
			tsserver.enable = true;
		};
	};
	programs.nixvim = {
		extraPlugins = [
			pkgs.vimPlugins.flutter-tools-nvim
		];
		extraConfigLua = ''
		require("flutter-tools").setup({})
		'';
	};
}
