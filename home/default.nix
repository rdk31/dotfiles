{ pkgs, ... }:
{
  imports = [
    ./nvim
    ./newsboat
    ./sway
    ./i3status-rs.nix
    ./kanshi.nix
    #./waybar
    ./tmux
    ./code
    ./zathura.nix
    ./ssh.nix
    ./git.nix
    ./zsh.nix
    #./foot.nix
    #./alacritty.nix
    ./kitty.nix
    ./mpv.nix
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
    atool
    file
    bind
    killall

    rsync
    lftp
    insync-v3

    xdg-utils

    btop
    neofetch
    onefetch

    vlc
    pavucontrol
    pulsemixer
    networkmanagerapplet
    gimp

    discord
    signal-desktop
    teams
    zoom-us

    libreoffice

    jdk
    jetbrains.idea-community

    unityhub

    #kicad

    remmina

    postman
    docker-compose_2
    mongodb-compass

    networkmanagerapplet

    polymc

    gnome3.adwaita-icon-theme

    platformio

    anki-bin

    joplin-desktop

    kdenlive

    qgroundcontrol
  ];
}
