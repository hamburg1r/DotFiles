{
	pkgs,
	...
}: {
	home.packages = with pkgs; [
		firefox
	];
	programs.firefox = {
		enable = false;
		profiles.hamburgir = {
			search = {
				engines = {
					"Nix Options" = {
						urls = [
							{
								template = "https://search.nixos.org/options";
								params = [
									{ name = "type"; value = "options"; }
									{ name = "query"; value = "{searchTerms}"; }
								];
							}
						];

						icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
						definedAlias = [ "@np" ];
					};
					"Nix Packages" = {
						urls = [
							{
								template = "https://search.nixos.org/packages";
								params = [
									{ name = "type"; value = "packages"; }
									{ name = "query"; value = "{searchTerms}"; }
								];
							}
						];

						icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
						definedAlias = [ "@np" ];
					};
				};
				force = true;
			};
		};
	};
}
