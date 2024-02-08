{ config, pkgs, ... }: {
  home.packages = with pkgs; [ git-lfs git-crypt ];

  programs.git = {
    enable = true;
    userName = "rdk31";
    userEmail = "rdk31@protonmail.com";
    difftastic.enable = true;
    #extraConfig = { pull.ff = "only"; };
  };
}
