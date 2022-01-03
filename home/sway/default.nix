{ config, pkgs, lib, ... }:
{
  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    extraSessionCommands = ''
      export SDL_VIDEODRIVER=wayland
      export QT_QPA_PLATFORM=wayland
      export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
      export _JAVA_AWT_WM_NONREPARENTING=1
      export MOZ_ENABLE_WAYLAND=1
      export WLR_RENDERER_ALLOW_SOFTWARE=1
      export XDG_CURRENT_DESKTOP=sway
    '';
    config = null;
    extraConfig = builtins.readFile ./config;
    systemdIntegration = true;
  };

  services.gammastep = {
    enable = true;
    latitude = 52.13;
    longitude = 21.00;
  };

  systemd.user.targets.tray = {
    Unit = {
      Description = "Home Manager System Tray";
      Requires = [ "graphical-session-pre.target" ];
    };
  };
  services.udiskie.enable = true;

  programs.mako = {
    enable = true;
    defaultTimeout = 2000;
  };

  home.packages = with pkgs; [
    dmenu
    wofi
    brightnessctl
    swaylock
    swayidle
    xwayland
    wl-clipboard
    grim
    slurp
  ];
}
