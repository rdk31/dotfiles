{ pkgs, ... }:
{
  home.packages = with pkgs; [
    newsboat
  ];

  xdg.configFile."newsboat/urls".source = ./../../secrets/newsboat-urls;
  xdg.configFile."newsboat/config".source = ./config;
}
