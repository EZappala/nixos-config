{ lib, pkgs, ... }
{
  imports = [ ../../modules ];
  home.username = "ellie";
  home.directory = "/home/ellie";
  home.stateVersion = "25.05"; # DO NOT CHANGE

  xresources.properties = {
    "Xcursor.size" = 16;
    "Xft.dpi" = 172;
  };

  home.packages = with pkgs; [
    vim
    neovim
    git
    ghostty
    
    ripgrep
    jq
    eza
    fzf
    bat
  ]; 
}
