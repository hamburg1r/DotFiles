# This file defines overlays
{ inputs, ... }: {
	# This one brings our custom packages from the 'pkgs' directory
	additions = final: prev: import ../pkgs { pkgs = final; } // {
		vimPlugins = prev.vimPlugins // final.callPackage ../pkgs/vim-plugins {  };
	};

	# This one contains whatever you want to overlay
	# You can change versions, add patches, set compilation flags, anything really.
	# https://nixos.wiki/wiki/Overlays
	modifications = final: prev: {
		# example = prev.example.overrideAttrs (oldAttrs: rec {
		# ...
		# });
		discord = prev.discord.override {
			withOpenASAR = false;
			withVencord = true;
			withTTS = true;
		};
		rofi = prev.rofi.override {
			plugins = [
				prev.rofi-calc
				prev.rofi-emoji
			];
		};
		rofi-wayland = prev.rofi-wayland.override {
			plugins = [
				prev.rofi-calc
				prev.rofi-emoji
			];
		};
	};

	# When applied, the unstable nixpkgs set (declared in the flake inputs) will
	# be accessible through 'pkgs.unstable'
	stable-packages = final: _prev: {
		stable = import inputs.nixpkgs-stable {
			system = final.system;
			config.allowUnfree = true;
		};
	};
}
