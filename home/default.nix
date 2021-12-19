{ pkgs, ... }:
{
  imports = [
    ./nvim
    ./newsboat
    ./sway
    ./waybar
    ./tmux
    #./code
    ./ssh.nix
    ./git.nix
    ./zsh.nix
    ./foot.nix
    ./lf.nix
    ./firefox.nix
    ./obs-studio.nix
  ];

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  home.packages = with pkgs; [
    exa
    bat
    ripgrep
    bc
    jq
    bind

    rsync
    lftp
    insync-v3

    btop
    neofetch
    onefetch

    vlc
    pavucontrol
    pulsemixer
    gimp

    signal-desktop
    teams
    libreoffice

    kicad

    postman
    docker-compose

    networkmanagerapplet

    lutris
    gnome3.adwaita-icon-theme
  ];
}
