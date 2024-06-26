{ pkgs, ... }: {
  services.kanshi = {
    enable = true;
    settings = [
      {
        profile.name = "undocked";
        profile.outputs = [{
          criteria = "eDP-1";
          status = "enable";
        }];
      }
      {
        profile.name = "dockedFHD";
        profile.outputs = [
          {
            criteria = "eDP-1";
            position = "1920,0";
            status = "enable";
          }
          {
            criteria = "Iiyama North America PL2480H 11181M2903890";
            position = "0,0";
            status = "enable";
          }
        ];
        profile.exec = [ "${pkgs.sway}/bin/swaymsg workspace 6, workspace 1" ];
      }
      {
        profile.name = "docked2K";
        profile.outputs = [
          {
            criteria = "eDP-1";
            position = "0,0";
            status = "enable";
          }
          {
            criteria = "Dell Inc. DELL S2721DGF 8LBQ023";
            position = "1536,0";
            status = "enable";
          }
        ];
        profile.exec = [ "${pkgs.sway}/bin/swaymsg workspace 6, workspace 1" ];
      }
      {
        profile.name = "unknown";
        profile.outputs = [
          {
            criteria = "eDP-1";
            status = "enable";
          }
          {
            criteria = "*";
            status = "enable";
          }
        ];
      }
    ];
  };
}
