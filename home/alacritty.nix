{
  programs.alacritty = {
    enable = true;
    settings = {
      font.size = 14.0;
      shell = {
        program = "/usr/bin/env";
        args = [ "zsh" "-c" "tmux" ];
      };
    };
  };
}
