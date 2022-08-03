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
    ./dev
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
    usbutils

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

    spotify

    #kicad

    remmina

    postman
    docker-compose

    mongodb-compass
    mongodb-tools

    networkmanagerapplet

    polymc

    gnome3.adwaita-icon-theme

    anki-bin

    joplin-desktop

    kdenlive

    qgroundcontrol

    yubikey-manager
    yubikey-manager-qt
  ];

  home.stateVersion = "22.11";
}
