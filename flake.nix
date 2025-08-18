{
  description = "Root flake";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/unstable";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, ... }: 
  let
    lib = nixpkgs.lib;
    pkgs = import nixpkgs { inherit system; };
    local_lib = (import ./lib {inherit lib; });
    name_from_nix_file = file: lib.strings.removeSuffix ".nix" (baseNameOf file);
  in {
    nixox_configurations = let 
      machines = local_lib.get_all_subdirs ./sys/machines;
      make_config = dir:
        (let
          user_data = import dir;
          system = user_data.system;
          pkgs = system;
        in lib.nixosSystem {
          inherit pkgs system;
          modues = [user_data.module];
          special_args = { inherit local_lib; };
        });
    in (builtins.listToAttrs (map (dir: {
      name = builtins.baseNameOf dir;
      value = make_config dir;
    }) machines));
    home_configurations = let
      user_dirs = local_lib.get_all_subdirs ./home/users;
      make_config = dir:
        (let
          user_data = import dir;
          pkgs = user_data.system;
        in home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [user_data.module];
          extra_special_args = { inherit local_lib; };
        });
    in (builtins.listToAttrs (map (file: {
      name = name_from_nxi_file file;
      value = make_config file;
    }) user_dirs));
  };
}
