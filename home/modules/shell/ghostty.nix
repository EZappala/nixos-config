{ inputs, ... }:
{
  imports = [
    inputs.hyprshell.homeModules.hyprshell
  ];

  programs.ghostty = {
    enable = true;
  }
}
