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
    typst

    inputs.zen-browser.packages."${target}".default
    # inputs.ghostty.packages."${target}".default

    # programming languages
    # TODO: Use nix develop, but requires extra setup
    nodejs
    go
    julia
    (python3.withPackages (python-pkgs: with python-pkgs; [
      pip
    ]))
    # TODO: For some reason you can't use luajit and lua51? luajit comes with lua52, but nvim needs lua51 for luarocks. Even tho luajit has a luarocks package???
    lua51Packages.lua
    lua51Packages.luarocks
    rustup

    #lib
    x264
    ffmpeg
  ];

  programs.home-manager.enable = true;
}
