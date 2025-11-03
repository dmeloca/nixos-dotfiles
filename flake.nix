{
description = "Basic NixOS flakes";
inputs = {
	nixpkgs.url = "nixpkgs/nixos-unstable";
	home-manager = {
		url = "github:nix-community/home-manager";
		inputs.nixpkgs.follows = "nixpkgs";
	};
};
outputs = { self, nixpkgs, home-manager, ... }: {
	nixosConfigurations.aleph0 = nixpkgs.lib.nixosSystem {
		modules = [
			./configuration.nix
			home-manager.nixosModules.home-manager {
				home-manager = {
				useGlobalPkgs = true;
				useUserPackages = true;
				users.ch1p = import ./home.nix;
				backupFileExtension = "backup";
			};
			}
		];
	};



};



}
