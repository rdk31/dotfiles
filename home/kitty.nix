{ config, ... }: {
  programs.kitty = {
    enable = true;
    settings = { font_size = "14.0"; };
  };

  home.sessionVariables = { TERMINAL = "kitty"; };
}
