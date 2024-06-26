{
  programs.i3status-rust = {
    enable = true;
    bars = {
      default = {
        blocks = [
          {
            block = "sound";
            format = " $output_name {$volume|MUTED} ";
            step_width = 0;
            click = [{
              button = "left";
              cmd = "pavucontrol --tab=1";
            }];
            mappings = {
              "alsa_output.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__hw_sofhdadsp__sink" =
                "XPS";
              "alsa_output.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__hw_sofhdadsp_3__sink" =
                "HDMI";
              "alsa_output.usb-C-Media_Electronics_Inc._USB_Audio_Device-00.analog-stereo" =
                "DOCK";
              "bluez_output.00_02_3C_65_96_A4.1" = "MUVO 1C";
              "alsa_output.usb-SteelSeries_Siberia_V2_Illuminated_000000000000-00.analog-stereo" =
                "SIBERIA";
              "bluez_output.6C_B1_33_84_41_3F.1" = "AIR PODS";
            };
          }
          {
            block = "net";
            device = "wlp0s20f3";
            format = " WIFI $signal_strength ";
            interval = 5;
          }
          {
            block = "battery";
            format = " $icon $percentage {$time |} ";
          }
          {
            block = "time";
            interval = 60;
            format = " $timestamp.datetime(f:'%a %d/%m %R') ";
          }
        ];
      };
    };
  };
}
