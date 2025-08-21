{ ... }:
{
  programs.kitty = {
    enable = true;
  };

  wayland.windowManager.hyprland = {
    enable = true;

    # must use nixos global module (~/sys/modules/hypr-global)
    package = null;
    portalPackage = null;
  };

  # let electron apps use wayland
  home.sessionVariables.NIXOS_OZONE_WL = "1";
}
