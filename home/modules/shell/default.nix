{ inputs, ... }:
{
  imports = [
    (import ./ghostty.nix {inherit inputs;})
    ./git
    ./neovim 
  ];
}
