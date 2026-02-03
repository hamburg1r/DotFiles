{ config, pkgs, ... }: {
  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    audio.enable = true;
    pulse.enable = true;
    jack.enable = true;
	wireplumber = {
		# TODO: check out NixOS wiki for updates on this
		configPackages = [
			(pkgs.writeTextDir "share/wireplumber/bluetooth.lua.d/51-bluez-config.lua" ''
				bluez_monitor.properties = {
					["bluez5.enable-sbc-xq"] = true,
					["bluez5.enable-msbc"] = true,
					["bluez5.enable-hw-volume"] = true,
					["bluez5.headset-roles"] = "[ hsp_hs hsp_ag hfp_hf hfp_ag ]"
				}
			'')
		];
	};
  };
}
