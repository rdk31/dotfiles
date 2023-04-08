{ config, ... }:
{
  programs.ssh = {
    enable = true;
    matchBlocks = {
      "nixhome" = {
        hostname = "nixhome";
        user = "rdk";
      };
    };
    extraConfig = ''
      Include /run/agenix/ssh-config
    '';
  };

}
