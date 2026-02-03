{
	description = "Flutter 3.0.4";
	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/23.05";
		flake-utils.url = "github:numtide/flake-utils";
	};
	outputs = { self, nixpkgs, flake-utils }:
		flake-utils.lib.eachDefaultSystem (system:
			let
				pkgs = import nixpkgs {
					inherit system;
					config = {
						android_sdk.accept_license = true;
						allowUnfree = true;
					};
				};
				buildToolsVersion = "30.0.3";
				androidComposition = pkgs.androidenv.composeAndroidPackages {
					buildToolsVersions = [ buildToolsVersion "28.0.3" ];
					platformVersions = [ "34" "33" ];
					abiVersions = [ "arm64-v8a" ];
					extraLicenses = [
						"android-googletv-license"
						"android-sdk-arm-dbt-license"
						"android-sdk-preview-license"
						"google-gdk-license"
						"mips-android-sysimage-license"
					];
				};
				androidSdk = androidComposition.androidsdk;
			in {
			devShell =
				with pkgs; mkShell rec {
					ANDROID_SDK_ROOT = "${androidSdk}/libexec/android-sdk";
					buildInputs = [
						flutter
						androidSdk
						gradle
						jdk21
					];
				};
			}
		);
}
