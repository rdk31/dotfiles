{ ... }:
{
  programs.ssh = {
    enable = true;
    extraConfig = builtins.readFile ./../secrets/ssh-config;
  };
}
