{ config, pkgs, ...}:
{
  services.kanshi = {
    enable = true;
    profiles = {
      undocked = {
        outputs = [
          {
            criteria = "eDP-1";
            status = "enable";
          }
        ];
      };
      dockedFHD = {
        outputs = [
          {
            criteria = "eDP-1";
            position = "1920,0";
          }
          {
            criteria = "Iiyama North America PL2480H 11181M2903890";
            position = "0,0";
          }
        ];
        exec = [ "${pkgs.sway}/bin/swaymsg workspace 6, workspace 1" ];
      };
      docked2K = {
        outputs = [
          {
            criteria = "eDP-1";
            position = "2560,480";
          }
          {
            criteria = "CHANGE ME";
            position = "0,0";
          }
        ];
        exec = [ "${pkgs.sway}/bin/swaymsg workspace 6, workspace 1" ];
      };
      unknown = {
        outputs = [
          {
            criteria = "eDP-1";
            status = "disable";
          }
          {
            criteria = "*";
          }
        ];
      };
    };
  };
}
