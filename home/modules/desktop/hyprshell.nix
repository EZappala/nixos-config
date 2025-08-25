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
          # mod = "super";
          launcher = {
            max_items = 6;
            plugins.websearch = {
                enable = true;
                engines = [
                  {
                      name = "Google";
                      url = "https://google.com/?q=%s";
                      key = "g";
                  }
                  {
                      name = "Wikipedia";
                      url = "https://en.wikipedia.org/wiki/Special:Search?search={}";
                      key = "w";
                  }
                ];
            };
          };
        };
        switch.enable = false;
      };
    };
  };
}
