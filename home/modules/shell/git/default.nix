{ config, pkgs, ... }:
{
  programs.git = {
    enable = true;
    userName = "Eloise Zappala";
    userEmail = "eloise.zappala@proton.me";
  };
}
