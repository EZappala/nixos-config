{ inputs, ... }:
{
  imports = [
    ./hyprland
    (import ./hyprshell.nix {inherit inputs;})
  ];
}
