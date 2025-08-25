{ ... }:
{
  programs.ghostty = {
    enable = true;
    settings = {
      keybind = [
        "ctrl+shift+h=previous_tab"
        "ctrl+shift+l=next_tab"
        "space>backslash=new_split:right"
        "space>shift+backslash=new_split:down"
        "ctrl+shift+equal=equalize_splits"
      ];
      theme = "rose-pine";
      window-decoration = "none";
    };
    installBatSyntax = true;
    installVimSyntax = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
  };
}
