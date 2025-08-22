{ lib, pkgs, target, inputs, ... }:
{
  imports = [ ../../modules ];
  home.username = "ellie";
  home.homeDirectory = "/home/ellie";
  home.stateVersion = "25.11"; # DO NOT CHANGE

  xresources.properties = {
    "Xcursor.size" = 16;
    "Xft.dpi" = 172;
  };

  home.packages = with pkgs; [
    ripgrep
    jq
    eza
    fzf
    bat
    gh

    inputs.zen-browser.packages."${target}".default
  ];

  programs.home-manager.enable = true;
}
