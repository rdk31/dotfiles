{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    git-lfs
    git-crypt
  ];

  programs.gpg.enable = true;
  services.gpg-agent.enable = true;

  programs.git = {
    enable = true;
    userName = "rdk31";
    userEmail = "rdk31@protonmail.com";
    signing = {
      key = "B6ADEEB57627C4AE";
      signByDefault = true;
    };
  };
}
