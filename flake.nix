{
  description = "Root flake";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
    	url = "github:0xc000022070/zen-browser-flake";
	    inputs.nixpkgs.follows = "nixpkgs";
    };
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, zen-browser, fenix, ... }:
  let 
    target = "x86_64-linux";
  in {
    nixosConfigurations = { 
      luffy = nixpkgs.lib.nixosSystem {
        system = target;
        specialArgs = { inherit inputs; };
        modules = [
          ./sys/machines/luffy/configuration.nix
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users."ellie" = import ./home/users/ellie-luffy;
	          home-manager.extraSpecialArgs = { inherit inputs; inherit target; };
	          home-manager.backupFileExtension = "bak";
          }
          ({ pkgs, ... }: {
          nixpkgs.overlays = [ fenix.overlays.default ];
          environment.systemPackages = with pkgs; [
            (fenix.complete.withComponents [
              "cargo"
              "clippy"
              "rust-src"
              "rustc"
              "rustfmt"
            ])
            rust-analyzer-nightly
          ];
        })
        ];
      };
    };
    
  };
}
