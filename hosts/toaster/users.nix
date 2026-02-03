{ pkgs, ... }: {
	users.users.hamburgir = {
		isNormalUser = true;
		description = "Shantnu Biswas";
		extraGroups = [ "adbusers" "networkmanager" "wheel" "storage" ];
		homeMode = "755";
		openssh.authorizedKeys.keys = [
			"ecdsa-sha2-nistp521 AAAAE2VjZHNhLXNoYTItbmlzdHA1MjEAAAAIbmlzdHA1MjEAAACFBAFe5uWV+2gQn9kJmE5y5xiQfZFzN/KtanbdA/SSF4+drNuFjAT8yORQejnB6drfn/kdlgITu7OZ+ikx8m2/VfjoKgAeVvPYN/7Hr0s8JdIqf4HmU9wc2SXHWP7my9kNDwzhpkucS3pT0T8kiLevNTY98N/hWmMqyVuqqhVB+g3mcAZVmQ== u0_a166@localhost"
		];
		packages = [ pkgs.gnome.gnome-software ];
		shell = pkgs.zsh;
	};
	services = {
		syncthing = {
			enable = true;
			user = "hamburgir";
			dataDir = "/home/hamburgir";
			settings = {
				devices = {
					"Realme Narzo N55" = { id = "CR5CNRG-3CZA2BC-CEG6HDJ-QOGGHIG-DUPSHZ5-K2AWGWD-XWCVB7A-7O42WAC"; };
				};
				folders = {
					"GBA ROMS" = {
						path = "/run/media/hamburgir/88a877a8-0f92-4cc2-b1e7-a121dde16fcb/files/roms/gba";
						devices = [ "Realme Narzo N55" ];
					};
					"Orgzly" = {
						path = "/home/hamburgir/orgzly";
						devices = [ "Realme Narzo N55" ];
					};
					"PSP ROMS" = {
						path = "/run/media/hamburgir/88a877a8-0f92-4cc2-b1e7-a121dde16fcb/files/roms/ppsspp/roms";
						devices = [ "Realme Narzo N55" ];
					};
					"Volatile" = {
						path = "/home/hamburgir/Documents/synced";
						devices = [ "Realme Narzo N55" ];
					};
					# "Documents" = {
					# 	path = "/home/hamburgir/Documents"
					# };
				};
			};
		};
	};
}
