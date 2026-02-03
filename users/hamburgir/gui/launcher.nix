{ config, pkgs, ... }: {
	programs = {
		rofi = {
			enable = false;
			package = pkgs.rofi-wayland;
			plugins = with pkgs; [
				rofi-calc
				rofi-emoji
				rofi-pass
				rofi-power-menu
				rofi-file-browser
			];
			# configPath = "$HOME/.cache/rofi/config.rasi";
			extraConfig = {
				modi = "drun,emoji,run";
				show-icons = true;
				display-drun = "";
				drun-display-format = "{name}";
			};
			# theme = let
			# 	inherit (config.lib.formats.rasi) mkLiteral;
			# in {
			# 	"*" = {
			# 		font = "Iosevka Nerd Font 14";
			# 		background = "#1E1D2FFF";
			# 		background-alt = "#282839FF";
			# 		foreground = "#D9E0EEFF";
			# 		selected = "#7AA2F7FF";
			# 		active = "#ABE9B3FF";
			# 		urgent = "#F28FADFF";
			# 	};
			#
			# 	window = {
			# 		transparency = "real";
			# 		location = mkLiteral "center";
			# 		anchor = mkLiteral "center";
			# 		fullscreen = true;
			# 		width = mkLiteral "1366px";
			# 		height = mkLiteral "768px";
			# 		x-offset = mkLiteral "0px";
			# 		y-offset = mkLiteral "0px";
			#
			# 		enabled = true;
			# 		margin = mkLiteral "0px";
			# 		padding = mkLiteral "0px";
			# 		border = mkLiteral "0px solid";
			# 		border-radius = mkLiteral "0px";
			# 		border-color = mkLiteral "@selected";
			# 		background-color = mkLiteral "black / 10%";
			# 		cursor = "default";
			# 	};
			#
			# 	# /*****----- Main Box -----*****/
			# 	mainbox = {
			# 		enabled = true;
			# 		spacing = mkLiteral "100px";
			# 		margin = mkLiteral "0px";
			# 		padding = mkLiteral "100px 225px";
			# 		border = mkLiteral "0px solid";
			# 		border-radius = mkLiteral "0px 0px 0px 0px";
			# 		border-color = mkLiteral "@selected";
			# 		background-color = mkLiteral "transparent";
			# 		children = [ "inputbar" "listview" ];
			# 	};
			#
			# 	# /*****----- Inputbar -----*****/
			# 	inputbar = {
			# 		enabled = true;
			# 		spacing = mkLiteral "10px";
			# 		margin = mkLiteral "0% 28%";
			# 		padding = mkLiteral "10px";
			# 		border = mkLiteral "1px solid";
			# 		border-radius = mkLiteral "6px";
			# 		border-color = mkLiteral "white / 25%";
			# 		background-color = mkLiteral "white / 5%";
			# 		text-color = mkLiteral "@foreground";
			# 		children = [ "prompt" "entry" ];
			# 	};
			#
			# 	prompt = {
			# 		enabled = true;
			# 		background-color = mkLiteral "transparent";
			# 		text-color = mkLiteral "inherit";
			# 	};
			# 	textbox-prompt-colon = {
			# 		enabled = true;
			# 		expand = false;
			# 		str = "::";
			# 		background-color = mkLiteral "transparent";
			# 		text-color = mkLiteral "inherit";
			# 	};
			# 	entry = {
			# 		enabled = true;
			# 		background-color = mkLiteral "transparent";
			# 		text-color = mkLiteral "inherit";
			# 		cursor = mkLiteral "text";
			# 		placeholder = "Search";
			# 		placeholder-color = mkLiteral "inherit";
			# 	};
			#
			# 	# /*****----- Listview -----*****/
			# 	listview = {
			# 		enabled = true;
			# 		columns = 7;
			# 		lines = 4;
			# 		cycle = true;
			# 		dynamic = true;
			# 		scrollbar = false;
			# 		layout = mkLiteral "vertical";
			# 		reverse = false;
			# 		fixed-height = true;
			# 		fixed-columns = true;
			#
			# 		spacing = mkLiteral "0px";
			# 		margin = mkLiteral "0px";
			# 		padding = mkLiteral "0px";
			# 		border = mkLiteral "0px solid";
			# 		border-radius = mkLiteral "0px";
			# 		border-color = mkLiteral "@selected";
			# 		background-color = mkLiteral "transparent";
			# 		text-color = mkLiteral "@foreground";
			# 		cursor = "default";
			# 	};
			# 	scrollbar = {
			# 		handle-width = mkLiteral "5px ";
			# 		handle-color = mkLiteral "@selected";
			# 		border-radius = mkLiteral "0px";
			# 		background-color = mkLiteral "@background-alt";
			# 	};
			#
			# 	# /*****----- Elements -----*****/
			# 	element = {
			# 		enabled = mkLiteral "true";
			# 		spacing = mkLiteral "15px";
			# 		margin = mkLiteral "0px";
			# 		padding = mkLiteral "35px 10px";
			# 		border = mkLiteral "0px solid";
			# 		border-radius = mkLiteral "15px";
			# 		border-color = mkLiteral "@selected";
			# 		background-color = mkLiteral "transparent";
			# 		text-color = mkLiteral "@foreground";
			# 		orientation = mkLiteral "vertical";
			# 		cursor = mkLiteral "pointer";
			# 	};
			# 	"element normal.normal" = {
			# 		background-color = mkLiteral "transparent";
			# 		text-color = mkLiteral "@foreground";
			# 	};
			# 	"element selected.normal" = {
			# 		background-color = mkLiteral "white / 5%";
			# 		text-color = mkLiteral "@foreground";
			# 	};
			# 	element-icon = {
			# 		background-color = mkLiteral "transparent";
			# 		text-color = mkLiteral "inherit";
			# 		size = mkLiteral "72px";
			# 		cursor = mkLiteral "inherit";
			# 	};
			# 	element-text = {
			# 		background-color = mkLiteral "transparent";
			# 		text-color = mkLiteral "@foreground";
			# 		highlight = mkLiteral "inherit";
			# 		cursor = mkLiteral "inherit";
			# 		vertical-align = mkLiteral "0.5";
			# 		horizontal-align = mkLiteral "0.5";
			# 	};
			#
			# 	# /*****----- Message -----*****/
			# 	error-message = {
			# 		padding = mkLiteral "100px";
			# 		border = mkLiteral "0px solid";
			# 		border-radius = mkLiteral "0px";
			# 		border-color = mkLiteral "@selected";
			# 		background-color = mkLiteral "black / 10%";
			# 		text-color = mkLiteral "@foreground";
			# 	};
			# 	textbox = {
			# 		background-color = mkLiteral "transparent";
			# 		text-color = mkLiteral "@foreground";
			# 		vertical-align = mkLiteral "0.5";
			# 		horizontal-align = mkLiteral "0.0";
			# 		highlight = mkLiteral "none";
			# 	};
			# };
		};
	};
}
