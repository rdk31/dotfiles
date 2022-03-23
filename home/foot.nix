{
  programs.foot = {
    enable = true;
    server.enable = true;
    settings = {
      main = {
        term = "xterm-256color";

        font = "monospace:size=10";
        dpi-aware = "yes";
      };

      url = {
        launch = "firefox \${url}";
      };

      mouse = {
        hide-when-typing = "yes";
      };
    };
  };
}
