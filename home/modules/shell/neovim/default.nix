{ config, pkgs, ... }: let
  nvimPath = "${config.home.homeDirectory}/.config/nvim";
in {
  programs.neovim = {
    enable = true;
  };
}
