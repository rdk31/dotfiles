{ pkgs, lib, ... }:
let
  mod = "Mod4";
in
{
  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    systemd.enable = true;
    extraSessionCommands = ''
      export SDL_VIDEODRIVER=wayland
      export QT_QPA_PLATFORM=wayland
      export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
      export _JAVA_AWT_WM_NONREPARENTING=1
      export MOZ_ENABLE_WAYLAND=1
      export WLR_RENDERER_ALLOW_SOFTWARE=1
      export XDG_CURRENT_DESKTOP=sway
    '';
    extraConfig = ''
      exec ${pkgs.sway-audio-idle-inhibit}/bin/sway-audio-idle-inhibit

      bindswitch --reload --locked lid:toggle exec ${./lid.sh}
      exec_always ${./lid.sh}

      include ${./recording}

      exec "mkfifo /tmp/wobpipe && tail -f /tmp/wobpipe | wob"
    '';
    config = {
      modifier = mod;
      terminal = "kitty";
      menu = "${pkgs.wofi}/bin/wofi --show drun --allow-images --gtk-dark";
      fonts = {
        names = [ "Fira Code" "Font Awesome 5 Free" ];
        size = 12.0;
      };
      gaps = {
        inner = 16;
        outer = 5;
        smartBorders = "on";
        smartGaps = true;
      };
      input = {
        "1739:52710:DLL0945:00_06CB:CDE6_Touchpad" = {
          dwt = "enabled";
          tap = "enabled";
          natural_scroll = "enabled";
          middle_emulation = "enabled";
        };
        "5426:103:Razer_Razer_Naga_Trinity" = {
          #accel_profile = "flat";
          pointer_accel = "-0.5";
        };
        "1:1:AT_Translated_Set_2_keyboard" = { xkb_layout = "pl"; };
        "1452:591:Keychron_Keychron_K1" = { xkb_layout = "pl"; };
        "1118:1896:Microsoft_Microsoft___SiderWinderTM_X4_Keyboard" = {
          xkb_layout = "pl";
        };
        # crashes firefox on sway reload
        #"*" = {
        #  xkb_layout = "pl";
        #};
      };
      output = {
        "eDP-1" = {
          scale = "1.25";
          position = "0,0";
        };
      };
      bars = [{
        fonts = {
          names = [ "Fira Code" "Font Awesome 5 Free" ];
          size = 12.0;
        };
        statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs ~/.config/i3status-rust/config-default.toml";
        position = "bottom";
      }];
      workspaceOutputAssign = [
        { workspace = "1"; output = "DP-3 DP-1 eDP-1"; }
        { workspace = "2"; output = "DP-3 DP-1 eDP-1"; }
        { workspace = "3"; output = "DP-3 DP-1 eDP-1"; }
        { workspace = "4"; output = "DP-3 DP-1 eDP-1"; }
        { workspace = "5"; output = "DP-3 DP-1 eDP-1"; }
        { workspace = "6"; output = "eDP-1"; }
        { workspace = "7"; output = "eDP-1"; }
        { workspace = "8"; output = "eDP-1"; }
        { workspace = "9"; output = "eDP-1"; }
        { workspace = "10"; output = "eDP-1"; }
      ];
      keybindings = lib.mkOptionDefault {
        "${mod}+0" = "workspace number 10";
        "${mod}+Shift+0" = "move container to workspace number 10";
        "${mod}+Tab" = "workspace back_and_forth";

        "XF86AudioRaiseVolume" =
          "exec pactl set-sink-volume @DEFAULT_SINK@ +5%";
        "XF86AudioLowerVolume" =
          "exec pactl set-sink-volume @DEFAULT_SINK@ -5%";
        "XF86AudioMute" = "exec pactl set-sink-mute @DEFAULT_SINK@ toggle";
        "XF86MonBrightnessDown" = "exec ${./brightness.sh} down";
        "XF86MonBrightnessUp" = "exec ${./brightness.sh} up";

        "${mod}+z" = "exec ${./power.sh}";
        "${mod}+x" = "exec ${./power.sh} lock";
        "${mod}+m" = "exec ${./switch-audio-output.sh}";
        "Print" = "exec ${./screenshot.sh}";
      };
    };
  };

  xdg.configFile."wob/wob.ini".text = ''
    anchor = bottom right
    bar_padding = 2
    margin = 10
    border_size = 2
    height = 25
    width = 200
  '';

  services.swayidle = {
    enable = true;
    events = [
      { event = "before-sleep"; command = "${pkgs.swaylock}/bin/swaylock -fc 000000"; }
      { event = "lock"; command = "${pkgs.swaylock}/bin/swaylock -fc 000000"; }
      { event = "after-resume"; command = "${pkgs.sway}/bin/swaymsg \"output * power on\""; }
    ];
    timeouts = [
      { timeout = 300; command = "${pkgs.swaylock}/bin/swaylock -fc 000000"; }
      {
        timeout = 600;
        command = "${pkgs.sway}/bin/swaymsg \"output * power off\"";
        resumeCommand = "${pkgs.sway}/bin/swaymsg \"output * power on\"";
      }
    ];
  };
  systemd.user.services.swayidle.Service.Environment = lib.mkAfter [ "WAYLAND_DISPLAY='wayland-1'" ];

  services.gammastep = {
    enable = true;
    latitude = 52.13;
    longitude = 21.0;
  };

  services.udiskie.enable = true;

  services.mako = {
    enable = true;
    defaultTimeout = 2000;
  };

  home.packages = with pkgs; [
    sway-contrib.grimshot # screenshots
    wl-clipboard # vim copy
    wf-recorder # screen recording
    slurp # screen recording
    bemenu
    brightnessctl
    wob
    pulseaudio
    swayidle
    swaylock
    udiskie
    wofi
  ];
}
