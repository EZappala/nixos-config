{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };
  outputs = inputs@{ self, nixpkgs, ... }: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      modules = [ 
          { nix.settings.experimental-features = ["nix-command" "flakes"]; }
	  ./configuration.nix 
        ];
    };
  };
}

