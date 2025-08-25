{ lib, pkgs, target, inputs, ... }:
{
  imports = [ ../../modules ];
  home.username = "ellie";
  home.homeDirectory = "/home/ellie";
  home.stateVersion = "25.11"; # DO NOT CHANGE

  # system.keyboard.enable = true; 
  # system.keyboard.remapCapsLockToEscape = true;

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
    unzip
    bluetui

    inputs.zen-browser.packages."${target}".default
    inputs.ghostty.packages."${target}".default

    # programming languages
    # TODO: Use nix develop, but requires extra setup
    nodejs
    go
    julia
    (python3.withPackages (python-pkgs: with python-pkgs; [
      pip
    ]))
    lua51Packages.lua
    lua51Packages.luarocks
    rustup
  ];

  programs.home-manager.enable = true;
}
