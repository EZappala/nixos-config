{ inputs, ... } : {
  imports = [
    inputs.hyprshell.homeModules.hyprshell
  ];

  programs.hyprshell = {
    enable = true;
    systemd.args = "-v";
    settings = {
      windows = {
        overview = {
          key = "super_l";
          modifier = "super";
          launcher = {
            max_items = 6;
            plugins.websearch.enable = false;
            plugins.terminal.enable = false;
            plugins.shell.enable = false;
          };
        };
        switch = {
          enable = false;
          show_workspaces = false;
        };
      };
    };
  };
}
