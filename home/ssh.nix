{ config, ... }:
{
  programs.ssh = {
    enable = true;
    extraConfig = ''
      Include /run/agenix/ssh-config
    '';
  };
}
