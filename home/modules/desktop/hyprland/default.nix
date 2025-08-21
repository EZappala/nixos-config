{ ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;

    # must use nixos global module (~/sys/modules/desktop/hypr-global)
    package = null;
    portalPackage = null;
    settings = {
      "$mod" = "SUPER";
      bind =
      [
      	"$mod, F, exec, zen"
	"$mod, T, exec, ghostty"
	"$mod, F12, exec, reboot"
	"$mod, Q, killactive"
	"$mod, M, exit"
      ];

      input = {
        kb_layout = "us";
	follow_mouse = 1;
	sensitivity = 0;
	touchpad = { 
	  natural_scroll = true;
	  tap-to-click = false;
	};
      };

      gestures = { 
        workspace_swipe = true;
	workspace_swipe_fingers = 4;
      };
    };
  };

  # let electron apps use wayland
  home.sessionVariables.NIXOS_OZONE_WL = "1"; }
