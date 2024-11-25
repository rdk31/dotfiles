{
  programs.tmux = {
    enable = true;
    terminal = "tmux-256color";
    baseIndex = 1;
    mouse = true;
    keyMode = "vi";
    customPaneNavigationAndResize = true;
    historyLimit = 100000;
    extraConfig = ''
      bind -r Tab last-window
    '';
  };
}
