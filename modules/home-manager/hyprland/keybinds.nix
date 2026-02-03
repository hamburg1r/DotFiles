{ config, ... }: {
	wayland.windowManager.hyprland.settings = let
		cfg = config.wm.keys;
	in {
		# Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
		bind = [
			# "${cfg.mod}, Return, exec, kitty"
			"${cfg.mod}, Return, exec, wezterm start"
			"${cfg.mod} SHIFT, c, killactive, "
			"${cfg.mod} SHIFT, q, exit, "
			# "${cfg.mod}, e, exec, kitty lf"
			"${cfg.mod}, e, exec, wezterm start lf"
			"${cfg.mod}, r, exec, ${config.commands.launcher.wayland}"
			"${cfg.mod} SHIFT, r, exec, ags quit; ags"
			# "${cfg.mod}, p, pseudo, " # dwindle"
			# "${cfg.mod}, t, togglesplit, " # dwindle"

			"${cfg.mod}, f, fullscreen, 0"
			"${cfg.mod} SHIFT, f, fullscreen, 1"
			"${cfg.mod} CTRL, f, fakefullscreen,"

			"${cfg.mod} SHIFT, space, togglefloating,"
			"${cfg.mod}, space, cyclenext, floating"
			"${cfg.mod} ALT, space, cyclenext, tiled"

			"${cfg.mod} SHIFT, minus, movetoworkspace, special"
			"${cfg.mod}, minus, togglespecialworkspace,"

			"${cfg.mod}, u, focusurgentorlast,"

			# Scroll through existing workspaces with mainMod + scroll
			"${cfg.mod}, mouse_down, workspace, e+1"
			"${cfg.mod}, mouse_up, workspace, e-1"

			", XF86AudioPlay, exec, playerctl play-pause"
			", XF86AudioPause, exec, playerctl play-pause"
			", XF86AudioNext, exec, playerctl next"
			", XF86AudioPrev, exec, playerctl previous"

			# Screenshot utilities
			", Print, exec, wayshot --stdout | swappy -f -"
			"SHIFT, Print, exec, wayshot -s \"$(slurp)\" --stdout | swappy -f -"

			", XF86MonBrightnessUp, exec, brightnessctl set 1%+"
			", XF86MonBrightnessDown, exec, brightnessctl set 1%-"
		] ++ (
			builtins.concatLists [
				( builtins.concatMap (
					key: if config.wm.hyprland.layout == "hy3" then [
						"${cfg.mod}, ${key}, hy3:movefocus, l"
						"${cfg.mod} SHIFT, ${key}, hy3:movewindow, l"
					] else [
						"${cfg.mod}, ${key}, movefocus, l"
					]
				) cfg.keybinds.movement.left )
				( builtins.concatMap (
					key: if config.wm.hyprland.layout == "hy3" then [
						"${cfg.mod}, ${key}, hy3:movefocus, r"
						"${cfg.mod} SHIFT, ${key}, hy3:movewindow, r"
					] else [
						"${cfg.mod}, ${key}, movefocus, r"
					]
				) cfg.keybinds.movement.right )
				( builtins.concatMap (
					key: if config.wm.hyprland.layout == "hy3" then [
						"${cfg.mod}, ${key}, hy3:movefocus, u"
						"${cfg.mod} SHIFT, ${key}, hy3:movewindow, u"
					] else [
						"${cfg.mod}, ${key}, movefocus, u"
					]
				) cfg.keybinds.movement.up )
				( builtins.concatMap (
					key: if config.wm.hyprland.layout == "hy3" then [
						"${cfg.mod}, ${key}, hy3:movefocus, d"
						"${cfg.mod} SHIFT, ${key}, hy3:movewindow, d"
					] else [
						"${cfg.mod}, ${key}, movefocus, d"
					]
				) cfg.keybinds.movement.down )
			]
		) ++ (
			if config.wm.hyprland.layout == "hy3" then [
				"${cfg.mod}, v, hy3:makegroup, v, force_empheral"
				"${cfg.mod}, b, hy3:makegroup, h, force_empheral"
				"${cfg.mod}, t, hy3:makegroup, tab, force_empheral"

				"${cfg.mod} CTRL, k, hy3:changefocus, raise"
				"${cfg.mod} CTRL, j, hy3:changefocus, lower"
			] else []
		) ++ (
			builtins.concatLists (
				builtins.genList (
					x: let
						ws = let c = (x + 1) / 10;
						in builtins.toString (x + 1 - (c * 10));
					in [
						"${cfg.mod}, ${ws}, workspace, ${builtins.toString (x + 1)}"
						(
							if config.wm.hyprland.layout == "hy3" then
								"${cfg.mod} SHIFT, ${ws}, hy3:movetoworkspace, ${builtins.toString (x + 1)}"
							else "${cfg.mod} SHIFT, ${ws}, hy3:movetoworkspace, ${builtins.toString (x + 1)}"
						)
					]
				) 10
			)
		);

		binde = [
			# Audio and media controls
			", XF86AudioMute, exec, pamixer -t"
			", XF86AudioLowerVolume, exec, pamixer -d 1"
			", XF86AudioRaiseVolume, exec, pamixer -i 1"

			## input
			"CTRL, XF86AudioMute, exec, pamixer --default-source -t"
			"CTRL, XF86AudioLowerVolume, exec, pamixer --default-source -d 1"
			"CTRL, XF86AudioRaiseVolume, exec, pamixer --default-source -i 1"
		];

		bindm = [
			# Move/resize windows with mainMod + LMB/RMB and dragging
			"${cfg.mod}, mouse:272, movewindow"
			"${cfg.mod}, mouse:273, resizewindow 1"
			"${cfg.mod} SHIFT, mouse:273, resizewindow"
		];
	};
}
