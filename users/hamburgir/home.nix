{ config, lib, outputs, options, pkgs, ... }: {
	imports = [
		./environment.nix
		./files.nix
		./gui
		# ./hamburgir.d/hypr
		./keybinds.nix
		./miscellaneous.nix
		./packages.nix
		./shell
		./theme.nix
		./xdg.nix
	] ++ (builtins.attrValues outputs.homeManagerModules);

	options = {
		commands = {
			rofi = {
				wayland = lib.mkOption {
					default = "${pkgs.rofi-wayland}/bin/rofi";
				};
				x11 = lib.mkOption {
					default = "${pkgs.rofi}/bin/rofi";
				};
			};
			launcher = {
				wayland = lib.mkOption {
					default = "${config.commands.rofi.wayland} -modi drun,run,window,combi -show drun";
					type = lib.types.str;
					description = "launcher command to be used in wayland sessions";
				};
				x11 = lib.mkOption {
					default = "${config.commands.rofi.x11} -modi drun,run,window,combi -show drun";
					type = lib.types.str;
					description = "launcher command to be used in x11 sessions";
				};
			};
		};
		wm = {
			rules = {
				focusType = lib.mkOption{
					default = 2;
					type = lib.types.number;
					description = ''
					0: Focus does not follow mouse, mouse and keyboard have same focus
					1: Focus follows mouse, mouse and keyboard have same focus
					2: Keyboard focus follows mouse click
					3: Keyboard focus and mouse focus are different
					'';
				};
				mouseRefocus = lib.mkOption {
					default = false;
					type = lib.types.bool;
					description = "Read on hyprland wiki";
				};
			};
			keys = {
				mod = lib.mkOption{
					default = "super";
					type = lib.types.str;
					description = "Default mod key";
				};
				keybinds = {
					movement = {
						left = lib.mkOption {
							default = [ "h" ];
							type = lib.types.listOf lib.types.str;
							description = "Keybind used for moving focus/windows to left";
						};
						right = lib.mkOption {
							default = [ "l" ];
							type = lib.types.listOf lib.types.str;
							description = "Keybind used for moving focus/windows to right";
						};
						up = lib.mkOption {
							default = [ "k" ];
							type = lib.types.listOf lib.types.str;
							description = "Keybind used for moving focus/windows to up";
						};
						down = lib.mkOption {
							default = [ "j" ];
							type = lib.types.listOf lib.types.str;
							description = "Keybind used for moving focus/windows to down";
						};
					};
				};
			};
			gesture = {
				enable = lib.mkOption{
					default = true;
					type = lib.types.bool;
				};
				switchWorkspace = lib.mkOption{
					default = true;
					type = lib.types.bool;
					description = "Use gestures to switch workspace";
				};
			};
			hyprland = {
				logo.enable = lib.mkOption {
					default = true;
					type = lib.types.bool;
					description = "Enable hyprland logo";
				};
				splash.enable = lib.mkOption {
					default = true;
					type = lib.types.bool;
					description = "Enable hyprland quotes at bottom";
				};
				forceHyprChan = lib.mkOption{
					default = true;
					type = lib.types.bool;
					description = "Anime character rendering UwU";
				};
				wallpaper = lib.mkOption {
					default = true;
					type = lib.types.bool;
					description = "Hyprland wallpaper";
				};
				layout = lib.mkOption {
					default = "hy3";
					type = lib.types.str;
					description = "Default layout";
				};
			};
		};
		hardware = {
			keyboard = {
				numlock = lib.mkOption{
					default = false;
					type = lib.types.bool;
					description = "Turn on numlock at startup";
				};
			};
			touchpad = {
				naturalScroll = lib.mkOption{
					default = false;
					type = lib.types.bool;
					description = "Content moves in the direction of finger movement";
				};
				dragLock = lib.mkOption{
					default = true;
					type = lib.types.bool;
					description = "Locks dragging for some time, gives a bit of time to reposition finger";
				};
				tapAndDrag = lib.mkOption{
					default = true;
					type = lib.types.bool;
					description = "Enables tap and drag";
				};
			};
			mouse = {
				sensitivity = lib.mkOption{
					default = 0.0;
					type = lib.types.float;
					description = "Mouse sensitivity from -1.0 to 1.0";
				};
			};
		};
	};
	# options.hyprland.config.file = lib.mkOption{
	#     default = "";
	#     type = lib.types.;
	# };

	config = {
		home = {
			username = "hamburgir";
			homeDirectory = "/home/hamburgir";

			enableNixpkgsReleaseCheck = true;

			sessionPath = [ "$HOME/.local/bin" ];
			stateVersion = "23.05";
		};

		nixpkgs = {
			overlays = [
				# Add overlays your own flake exports (from overlays and pkgs dir):
				outputs.overlays.additions
				outputs.overlays.modifications
				outputs.overlays.stable-packages

				# You can also add overlays exported from other flakes:
				# neovim-nightly-overlay.overlays.default

				# Or define it inline, for example:
				# (final: prev: {
				#   hi = final.hello.overrideAttrs (oldAttrs: {
				#     patches = [ ./change-hello-to-hi.patch ];
				#   });
				# })
			];
			config = {
				allowUnfree = true;
				allowUnfreePredicate = (_: true);
			};
		};

		manual.manpages.enable = true;
		manual.html.enable = true;
		manual.json.enable = true;
		services.network-manager-applet.enable = true;

##### Hyprland
		wm.blur.enable = true;
		wm.gaps.singleWindow = false;
	};
}
