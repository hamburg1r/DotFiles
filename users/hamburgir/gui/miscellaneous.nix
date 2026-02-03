{ inputs, pkgs, ... }: {
	# nixpkgs.overlays = [
	# 	inputs.eww.overlays.default
	# 	inputs.rust-overlay.overlays.default
	# ];

	programs = {
		ags = {
			enable = true;
			
			# null or path, leave as null if you don't want hm to manage the config
			# configDir =	./ags;

			# package = inputs.ags.packages.x86_64-linux.default;
			# packages to add to gjs's runtime
			# extraPackages = [ pkgs.libnotify pkgs.gtksourceviewmm pkgs.gtksourceview4 pkgs.gtksourceview5 pkgs.gtksourceview pkgs.libsoup_3 ];
			extraPackages = with pkgs; [
				libsoup_3
				libgtop
				inotify-tools
			];
		};
		eww = {
			enable = false;
			configDir = ./eww;
			# package = pkgs.eww-wayland;
			package = (pkgs.writeShellScriptBin "eww" ''
			[[ "$1" -eq "daemon" ]] && echo "${pkgs.eww-wayland}/bin/eww" > /tmp/eww.cmd
			${pkgs.eww-wayland}/bin/eww "$@"
			'');
		};
		waybar = {
			enable = true;
			settings = {
				mainBar = {
					layer = "top";
					position = "top";
					height = 30;
					output = [
						"eDP-1"
					];
					modules-left = [
						"hyprland/workspaces"
						"temperature"
						"pulseaudio"
						"hyprland/submap"
						# "wlr/taskbar"
					];
					modules-center = [
						"hyprland/window"
						"clock"
					];
					modules-right = [
						"privacy"
						"backlight"
						"network"
						"disk"
						"memory"
						"cpu"
						"battery"
						"tray"
						"group/group-power"
					];

					"hyprland/workspaces" = {
						active-only = false;
						# format = "{icon}";
						format-icons = {
							"1" = "一";
							"2" = "二";
							"3" = "三";
							"4" = "四";
							"5" = "五";
							"6" = "六";
							"7" = "七";
							"8" = "八";
							"9" = "九";
							"10" = "十";
							"urgent" = "";
							"focused" = "";
							"default" = "";
						};
						on-scroll-up = "hyprctl dispatch workspace e+1";
						on-scroll-down = "hyprctl dispatch workspace e-1";
					};

					"group/group-power" = {
						orientation = "inherit";
						drawer = {
							transition-duration = 500;
							children-class = "not-power";
							transition-left-to-right = false;
						};
						modules = [
							"custom/power"
							"custom/quit"
							"custom/lock"
							"custom/reboot"
						];
					};
					"custom/quit" = {
						format = "󰗼";
						tooltip = false;
						on-click = "hyprctl dispatch exit";
					};
					"custom/lock" = {
						format = "󰍁";
						tooltip = false;
						on-click = "swaylock";
					};
					"custom/reboot" = {
						format = "󰜉";
						tooltip = false;
						on-click = "reboot";
					};
					"custom/power" = {
						format = "";
						tooltip = false;
						on-click = "shutdown now";
					};
					battery = {
						# bat = "BAT2";
						interval = 60;
						states = {
							warning = 30;
							critical = 15;
						};
						format = "{capacity}% {icon}";
						format-icons = ["" "" "" "" ""];
						max-length = 25;
					};
					backlight = {
						# device = "intel_backlight";
						on-scroll-up = "brightnessctl set 1%+";
						on-scroll-down = "brightnessctl set 1%-";
						format = "{icon} {percent}%";
						format-icons = [
							""
							""
							""
							""
						];
					};
					network = {
					  interface = "wlp2s0";
					  format = "{ifname}";
					  format-wifi = "{essid} ({signalStrength}%) ";
					  format-ethernet = "{ipaddr}/{cidr} 󰊗";
					  format-disconnected = "";
					  tooltip-format = "{ifname} via {gwaddr} 󰊗";
					  tooltip-format-wifi = "{essid} ({signalStrength}%) ";
					  tooltip-format-ethernet = "{ifname} ";
					  tooltip-format-disconnected = "Disconnected";
					  max-length = 50;
					};
					privacy = {
						icon-spacing = 4;
						icon-size = 18;
						transition-duration = 250;
						modules = [
						  {
							type = "screenshare";
							tooltip = true;
							tooltip-icon-size = 24;
						  }
						  {
							type = "audio-out";
							tooltip = true;
							tooltip-icon-size = 24;
						  }
						  {
							type = "audio-in";
							tooltip = true;
							tooltip-icon-size = 24;
						  }
						];
					};
					disk = {
						interval = 30;
						format = " {used}";
						path = "/home";
						tooltip = true;
						tooltip-format = "{used}/{total} => {path} {percentage_used}%";
					};
					memory = {
						on-click = "${pkgs.kitty}/bin/kitty bashtop";
						interval = 1;
						format = "﬙ {percentage}%";
						states = {
							warning = 85;
						};
					};
					cpu = {
						interval = 1;
						format = " {usage}%";
					};
				};
			};
			style = ''
				/*
				*
				* Catppuccin Mocha palette
				* Maintainer: rubyowo
				*
				*/

				@define-color base   #1e1e2e;
				@define-color mantle #181825;
				@define-color crust  #11111b;

				@define-color text     #cdd6f4;
				@define-color subtext0 #a6adc8;
				@define-color subtext1 #bac2de;

				@define-color surface0 #313244;
				@define-color surface1 #45475a;
				@define-color surface2 #585b70;

				@define-color overlay0 #6c7086;
				@define-color overlay1 #7f849c;
				@define-color overlay2 #9399b2;

				@define-color blue      #89b4fa;
				@define-color lavender  #b4befe;
				@define-color sapphire  #74c7ec;
				@define-color sky       #89dceb;
				@define-color teal      #94e2d5;
				@define-color green     #a6e3a1;
				@define-color yellow    #f9e2af;
				@define-color peach     #fab387;
				@define-color maroon    #eba0ac;
				@define-color red       #f38ba8;
				@define-color mauve     #cba6f7;
				@define-color pink      #f5c2e7;
				@define-color flamingo  #f2cdcd;
				@define-color rosewater #f5e0dc;

				/* Global */
				* {
				  font-family: "FiraCode Nerd Font";
				  font-size: .9rem;
				  border-radius: 1rem;
				  transition-property: background-color;
				  transition-duration: 0.5s;
				  background-color: shade(@base, 0.9);
				}

				@keyframes blink_red {
				  to {
					background-color: @red;
					color: @base;
				  }
				}

				.warning, .critical, .urgent {
				  animation-name: blink_red;
				  animation-duration: 1s;
				  animation-timing-function: linear;
				  animation-iteration-count: infinite;
				  animation-direction: alternate;
				}

				#mode, #clock, #memory, #temperature, #cpu, #custom-weather,
				#mpd, #idle_inhibitor, #backlight, #pulseaudio, #network, 
				#battery, #custom-powermenu, #custom-cava-internal,
				#custom-launcher, #tray, #disk, #custom-pacman, #custom-scratchpad-indicator {
				  padding-left: .6rem;
				  padding-right: .6rem;
				}

				/* Bar */
				window#waybar {
				  background-color: transparent;
				}

				window > box {
				  background-color: transparent;
				  margin: .3rem;
				  margin-bottom: 0;
				}


				/* Workspaces */
				#workspaces:hover {
				  background-color: @green;
				}

				#workspaces button {
				  padding-right: .4rem;
				  padding-left: .4rem;
				  padding-top: .1rem;
				  padding-bottom: .1rem;
				  color: @red;
				  /* border: .2px solid transparent; */
				  background: transparent;
				}

				#workspaces button.focused {
				  color: @blue;
				}

				#workspaces button:hover {
				  /* border: .2px solid transparent; */
				  color: @rosewater;
				}

				/* Tooltip */
				tooltip {
				  background-color: @base;
				}

				tooltip label {
				  color: @rosewater;
				}

				/* battery */
				#battery {
				  color: @mauve;
				}
				#battery.full {
				  color: @green;
				}
				#battery.charging{
				  color: @teal;
				}
				#battery.discharging {
				  color: @peach;
				}
				#battery.critical:not(.charging) {
				  color: @pink;
				}
				#custom-powermenu {
				  color: @red;
				}

				/* mpd */
				#mpd.paused {
				  color: @pink;
				  font-style: italic;
				}
				#mpd.stopped {
				  color: @rosewater;
				  /* background: transparent; */
				}
				#mpd {
				  color: @lavender;
				}

				/* Extra */
				#custom-cava-internal{
				  color: @peach;
				  padding-right: 1rem;
				}
				#custom-launcher {
				  color: @yellow;
				}
				#memory {
				  color: @peach;
				}
				#cpu {
				  color: @blue;
				}
				#clock {
				  color: @rosewater;
				}
				#idle_inhibitor {
				  color: @green;
				}
				#temperature {
				  color: @sapphire;
				}
				#backlight {
				  color: @green;
				}
				#pulseaudio {
				  color: @mauve;  /* not active */
				}
				#network {
				  color: @pink; /* not active */
				}
				#network.disconnected {
				  color: @foreground;  /* not active */
				}
				#disk {
				  color: @maroon;
				}
				#custom-pacman{
				  color: @sky;
				}
				#custom-scratchpad-indicator {
				  color: @yellow
				}
				#custom-weather {
				  color: @red;
				}
			'';
		};
	};
	home.packages = with pkgs; [
		helvum
		swww
		sassc
		keepassxc
	];
}
