{ inputs, pkgs, ... }: {
	home.packages = [
		pkgs.eza
	]; 
	programs = {
		bat = {
			enable = true;
			config = {
				theme = "catppuccin-mocha";
				tabs = "4";
			};
			themes = {
				catppuccin-latte = {
					src = inputs.catppuccin-bat;
					file = "Catppuccin-latte.tmTheme";
				};
				catppuccin-frappe = {
					src = inputs.catppuccin-bat;
					file = "Catppuccin-frappe.tmTheme";
				};
				catppuccin-macchiato = {
					src = inputs.catppuccin-bat;
					file = "Catppuccin-macchiato.tmTheme";
				};
				catppuccin-mocha = {
					src = inputs.catppuccin-bat;
					file = "Catppuccin-mocha.tmTheme";
				};
			};
		};
		less = {
			enable = true;
			keys = ''
			i quit
			'';
		};
	};
}
