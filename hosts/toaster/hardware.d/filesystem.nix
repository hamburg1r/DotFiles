{ ... }: {
	boot.tmp.cleanOnBoot = true;
	boot.supportedFilesystems = [ "btrfs" "ext4" "fat32" "ntfs" "vfat" ];
	fileSystems."/nix" = {
		device = "/dev/disk/by-label/root";
		fsType = "btrfs";
		options = [ "subvol=nix" ];
	};

	fileSystems."/" = {
		device = "/dev/disk/by-label/root";
		fsType = "btrfs";
		options = [ "subvol=root" ];
	};

	fileSystems."/home" = {
		device = "/dev/disk/by-label/home";
		fsType = "btrfs";
	};

	fileSystems."/boot/efi" = {
		device = "/dev/disk/by-label/EFI";
		fsType = "vfat";
	};

	swapDevices = [{
		device = "/dev/disk/by-label/swap";
		priority = 60;
		size = null;
	}];
}
