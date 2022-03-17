{ config, pkgs, ...}:
{
  programs.i3status-rust = {
    enable = true;
    bars = {
      default = {
        blocks = [
           { 
             block = "sound"; 
             format = "{output_name} {volume}";
             step_width = 0;
             on_click = "pavucontrol --tab=1";
             mappings = {
              "alsa_output.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__hw_sofhdadsp__sink" = "XPS";
              "alsa_output.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__hw_sofhdadsp_3__sink" = "HDMI";
             };
           }
           {
             block = "net";
             device = "wlp0s20f3";
             format = "{ssid} {signal_strength}";
             hide_inactive = true;
             interval = 5;
           }
           {
             block = "battery";
             format = "{percentage} {time}";
           }
           {
             block = "time";
             interval = 60;
             format = "%a %d/%m %R";
           }
        ];
      };
    };
  };
}
