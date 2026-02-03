# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, inputs, outputs, ... }: with pkgs.lib; {
	imports = [
		./hardware-configuration.nix
		./audio.nix
		./automount.nix
		./bluetooth.nix
		./boot
		./dev.nix
		./environment.nix
		./gui.nix
		./input.nix
		./logind.nix
		./miscellaneous.nix
		./mysql.nix
		./network.nix
		./packages.nix
		./users.nix
		./vms.nix
		./zerotier.nix
	];

	nixpkgs = {
		overlays = [
			outputs.overlays.additions
			outputs.overlays.modifications
			outputs.overlays.stable-packages

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
		};
	};

	nix = {
		# This will add each flake input as a registry
		# To make nix3 commands consistent with your flake
		registry = lib.mapAttrs (_: value: { flake = value; }) inputs;

		# This will additionally add your inputs to the system's legacy channels
		# Making legacy nix commands consistent as well, awesome!
		nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;

		settings = {
			accept-flake-config = true;
			allowed-users = [ "root" "@wheel" ];
			auto-optimise-store = true;
			# Enable flakes and new 'nix' command
			experimental-features = "nix-command flakes";
			min-free = 1073741824;
			max-free = 1073741824;
		};
		# Deduplicate and optimize nix store
		#auto-optimise-store = true;

		gc = {
			automatic = true;
			dates = "weekly";
			options = "--delete-older-than 3d";
		};
	};
	services.flatpak.enable = true;

	# Some programs need SUID wrappers, can be configured further or are
	# started in user sessions.
	programs.mtr.enable = true;
	programs.nix-ld = {
		enable = true;
		libraries = with pkgs; [];
	};
	# programs.gnupg.agent = {
	#   enable = true;
	#   enableSSHSupport = true;
	# };

	# List services that you want to enable:

	# This value determines the NixOS release from which the default
	# settings for stateful data, like file locations and database versions
	# on your system were taken. It‘s perfectly fine and recommended to leave
	# this value at the release version of the first install of this system.
	# Before changing this value read the documentation for this option
	# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
	programs.adb.enable = true;
	system.stateVersion = "23.05"; # Did you read the comment?
}
