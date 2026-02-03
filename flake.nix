{
	description = "Your new nix config";

	inputs = {
		# Nixpkgs
		nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-23.05";
		# You can access packages and modules from different nixpkgs revs
		# at the same time. Here's an working example:
		nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
		# Also see the 'unstable-packages' overlay at 'overlays/default.nix'.

		# Home manager
		home-manager.url = "github:nix-community/home-manager";# release-23.05
		home-manager.inputs.nixpkgs.follows = "nixpkgs";

		catppuccin-sddm = {
			url = "https://github.com/catppuccin/sddm/releases/download/v1.0.0/catppuccin-mocha.zip";
			flake = false;
		};
		catppuccin-bat = {
			url = "github:catppuccin/bat";
			flake = false;
		};
		grub2-themes.url = "github:vinceliuice/grub2-themes";

		wlroots = {
			type = "gitlab";
			host = "gitlab.freedesktop.org";
			owner = "wlroots";
			repo = "wlroots";
			rev = "50eae512d9cecbf0b3b1898bb1f0b40fa05fe19b";
			flake = false;
		};
		hyprland.url = "github:hyprwm/Hyprland";
		hyprland.inputs.wlroots.follows = "wlroots";
		hy3 = {
			url = "github:outfoxxed/hy3";
			inputs.hyprland.follows = "hyprland";
		};

		nixvim = {
			url = "github:nix-community/nixvim";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		# my-nixvim = {
		# 	url = "path:///home/hamburgir/repo/nixvim";
		# };

		webcord.url = "github:fufexan/webcord-flake";

		# eww.url = "git+file:///home/hamburgir/repo/eww";
		# eww.url = "github:elkowar/eww";
		# rust-overlay.url = "github:oxalica/rust-overlay";
		ags.url = "github:Aylur/ags";

		# xremap.url = "github:xremap/nix-flake";

		# Shameless plug: looking for a way to nixify your themes and make
		# everything match nicely? Try nix-colors!
		# nix-colors.url = "github:misterio77/nix-colors";

		wallpaper = {
			url = "github:h4m6urg1r/wallpapers";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		zsh-f-sy-h ={
			url = "github:zdharma-continuum/fast-syntax-highlighting";
			flake = false;
		};

		fabric = {
			url = "git+file:///home/hamburgir/repo/fabric";
		};
	};

	outputs = { self, nixpkgs, home-manager, ... }@inputs:
		let
		inherit (self) outputs;
		forAllSystems = nixpkgs.lib.genAttrs [
			"aarch64-linux"
			"i686-linux"
			"x86_64-linux"
			"aarch64-darwin"
			"x86_64-darwin"
		];
		in rec {
			# Your custom packages
			# Acessible through 'nix build', 'nix shell', etc
			packages = forAllSystems (system:
				let pkgs = nixpkgs.legacyPackages.${system};
				in import ./pkgs { inherit pkgs; }
			);
			# Devshell for bootstrapping
			# Acessible through 'nix develop' or 'nix-shell' (legacy)
			devShells = forAllSystems (system:
				let pkgs = nixpkgs.legacyPackages.${system};
				in import ./shell.nix { inherit pkgs; }
			);

			# Your custom packages and modifications, exported as overlays
			overlays = import ./overlays { inherit inputs; };
			# Reusable nixos modules you might want to export
			# These are usually stuff you would upstream into nixpkgs
			nixosModules = import ./modules/nixos;
			# Reusable home-manager modules you might want to export
			# These are usually stuff you would upstream into home-manager
			homeManagerModules = import ./modules/home-manager;

			nixosConfigurations = {
				toaster = nixpkgs.lib.nixosSystem {
					specialArgs = { inherit inputs outputs; };
					modules = [
						inputs.grub2-themes.nixosModules.default
						inputs.wallpaper.nixosModules.default
						./hosts/toaster/configuration.nix
					];
				};
			};

			homeConfigurations = {
				hamburgir = home-manager.lib.homeManagerConfiguration {
					pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
					extraSpecialArgs = { inherit inputs outputs; };
					modules = [
						inputs.ags.homeManagerModules.default
						inputs.hyprland.homeManagerModules.default
						inputs.nixvim.homeManagerModules.nixvim
						inputs.wallpaper.homeManagerModules.default
						inputs.webcord.homeManagerModules.default
						./users/hamburgir/home.nix
					];
				};
			};
			templates = import ./templates;
	};
}
