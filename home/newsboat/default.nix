{ pkgs, config, ... }:
{
  home.packages = with pkgs; [
    newsboat
  ];

  xdg.configFile."newsboat/config".source = ./config;
  xdg.configFile."newsboat/urls".source = config.lib.file.mkOutOfStoreSymlink "/run/agenix/newsboat-urls";
}
