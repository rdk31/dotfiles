{ pkgs, ... }:
{
  imports = [
    ./nvim
    ./newsboat
    ./sway
    ./i3status-rs.nix
    ./kanshi.nix
    ./tmux
    ./code
    ./ssh.nix
    ./git.nix
    ./zsh.nix
    #./foot.nix
    ./kitty.nix
    ./lf.nix
    ./firefox.nix
    ./dev
    ./scripts.nix
  ];

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
    ];
  };

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
    rclone
    lftp
    #insync-v3

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
    #teams
    zoom-us

    libreoffice

    jdk

    spotify

    kicad

    remmina

    postman
    docker-compose

    mongodb-compass
    mongodb-tools

    networkmanagerapplet

    prismlauncher

    gnome.adwaita-icon-theme

    anki-bin

    yubikey-manager
    yubikey-manager-qt

    lazygit

    logisim-evolution
  ];

  home.stateVersion = "22.11";
}
