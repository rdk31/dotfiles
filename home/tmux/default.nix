{ pkgs, ... }: {
  home.packages = with pkgs; [ tmux ];

  xdg.configFile."tmux/tmux.conf".source = ./tmux.conf;
}
