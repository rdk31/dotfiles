{ pkgs, config, ... }:
{
  home.packages = with pkgs; [
    newsboat
  ];

  xdg.configFile."newsboat/config".source = ./config;
}
