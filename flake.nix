{
  description = "Root flake";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, ... }: 
  let
    lib = nixpkgs.lib;
    makePkgs = system: (import nixpkgs { inherit system; });
    localLib = (import ./lib {inherit lib; });
    nameFromNixFile = file: lib.strings.removeSuffix ".nix" (baseNameOf file);
  in {
    nixosConfigurations = let 
      machines = localLib.getAllSubdirs ./sys/machines;
      makeConfig = dir:
        (let
          userData = import dir;
          system = userData.system;
          pkgs = makePkgs system;
        in lib.nixosSystem {
          inherit pkgs system;
          modules = [userData.module];
          specialArgs = { inherit localLib; };
        });
    in (builtins.listToAttrs (map (dir: {
      name = builtins.baseNameOf dir;
      value = makeConfig dir;
    }) machines));
    homeConfigurations = let
      userDirs = localLib.getAllSubdirs ./home/users;
      makeConfig = dir:
        (let
          userData = import dir;
          pkgs = makePkgs userData.system;
        in home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [userData.module];
          extraSpecialArgs = { inherit localLib; };
        });
    in (builtins.listToAttrs (map (file: {
      name = nameFromNixFile file;
      value = makeConfig file;
    }) userDirs));
  };
}
