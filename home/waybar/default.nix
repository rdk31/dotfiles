{ pkgs, ...}:
{
  programs.waybar = {
    enable = true;
    systemd.enable = true;
  #  settings = builtins.fromJSON (builtins.readFile ./config);
  #  style = builtins.readFile ./style.css;
  };

  home.packages = with pkgs; [
    waybar
  ];

  xdg.configFile."waybar/config".source = ./config;
  xdg.configFile."waybar/style.css".source = ./style.css;
}
