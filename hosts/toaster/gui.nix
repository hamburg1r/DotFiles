{ inputs, outputs, pkgs, lib, config, ... }:let
	package = {
		cfg,
		flavour,
		lib,
		pkgs,
		qtbase,
		qtsvg,
		qtgraphicaleffects,
		qtquickcontrols2,
		srcPath,
		wrapQtAppsHook,
		stdenv
	}: stdenv.mkDerivation rec {
		name = "Catppuccin-${flavour}";

		src = "${inputs.catppuccin-sddm}/src/${srcPath}";

		nativeBuildInputs = [
			wrapQtAppsHook
			pkgs.imagemagick
		];
		buildInputs = [
			qtbase
			qtsvg
			qtgraphicaleffects
			qtquickcontrols2
		];

		dontUnpack = true;
		installPhase = ''
			mkdir -p $out/share/sddm/themes
			cp -aR $src $out/share/sddm/themes/${name}
			chmod +w -R $out
			if [[ ${if cfg.background == null then "false" else "true"} ]]; then
				convert ${cfg.background} $out/share/sddm/themes/${name}/backgrounds/wall.jpg
			fi
		'';
		postFixup = ''
			sed -i '/^Font=/s/.*/Font="${cfg.font}"/' $out/share/sddm/themes/${name}/theme.conf
			sed -i '/^FontSize=/s/.*/FontSize="${cfg.fontSize}"/' $out/share/sddm/themes/${name}/theme.conf
			sed -i '/^ClockEnabled=/s/.*/ClockEnabled="${cfg.clockEnabled}"/' $out/share/sddm/themes/${name}/theme.conf
			sed -i '/^CustomBackground=/s/.*/CustomBackground="${if cfg.background != null then cfg.customBackground else "false"}"/' $out/share/sddm/themes/${name}/theme.conf
			sed -i '/^LoginBackground=/s/.*/LoginBackground="${cfg.loginBackground}"/' $out/share/sddm/themes/${name}/theme.conf
		'';

		meta = {
		description = "Catppuccin ${flavour} sddm theme";
		license = lib.licenses.gpl3;
		};
	};
	catppuccin-sddm = pkgs.libsForQt5.callPackage package{
		cfg = {
			font = "Noto Sans";
			fontSize = "9";
			clockEnabled = "true";
			customBackground = "true";
			loginBackground = "true";
			background = config.wallpaper.sddm.output;
		};
		flavour = "Mocha";
		srcPath = "catppuccin-mocha";
	};
in {
	# Enable the X11 windowing system.

	wallpaper.sddm = {
		dir = "your_name";
		file = "VillageComet.jpg";
	};

	services.xserver.desktopManager = {
		xfce.enable = false;
		gnome.enable = false;
		plasma5.enable = false;
	};


	services.xserver.windowManager = {
		qtile.enable = false;
		i3.enable = true;
		herbstluftwm.enable = false;
		awesome = {
			enable = false;
			luaModules = with pkgs.luaPackages;[
				luarocks
				luadbi-mysql
			];
		};
	};

	services.xserver.excludePackages = [ pkgs.xterm ];

	programs.sway.enable = true;

	environment.systemPackages = [
		catppuccin-sddm
	];
	services.xserver.displayManager = {
		gdm.enable = false;
		sddm = {
			enable = true;
			theme = "Catppuccin-Mocha";
		};
		lightdm.enable = false;
	};

	# Configure keymap in X11
	services.xserver = {
		enable = true;
		xkb = {
			layout = "us";
			variant = "";
		};
	};
	services.gnome.gnome-keyring.enable = true;
	programs.hyprland = {
		enable = true;
		xwayland.enable = true;
	};
	xdg.portal = {
		enable = true;
		extraPortals = with pkgs; [
			xdg-desktop-portal-wlr
			xdg-desktop-portal-gtk
			xdg-desktop-portal-hyprland
		];
		# gtkUsePortal=true;
	};

	security.polkit.enable = true;
	systemd = {
		user.services.polkit-gnome-authentication-agent-1 = {
			description = "polkit-gnome-authentication-agent-1";
			wantedBy = [ "graphical-session.target" ];
			wants = [ "graphical-session.target" ];
			after = [ "graphical-session.target" ];
			serviceConfig = {
				Type = "simple";
				ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
				Restart = "on-failure";
				RestartSec = 1;
				TimeoutStopSec = 10;
			};
		};
	};

	# Enable touchpad support (enabled default in most desktopManager).
	# services.xserver.libinput.enable = true;
}
