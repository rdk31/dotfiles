{ ... }:
{
  programs.kitty = {
    enable = true;
    settings = {
      font_size = "14.0";
      enable_audio_bell = false;
      scrollback_lines = 100000;
    };
    shellIntegration.enableZshIntegration = true;
  };

  home.sessionVariables = {
    TERMINAL = "kitty";
  };
}
