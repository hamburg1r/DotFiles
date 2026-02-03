{ pkgs, ... }: {
	home.shellAliases = {
		ls = "eza";
		la = "ls -A";
		ll = "ls -l";
		lla = "ls -la";
		cat = "bat";
	};
}
