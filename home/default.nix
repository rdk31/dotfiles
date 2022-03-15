{ pkgs, ... }:
{
  imports = [
    ./nvim
    ./newsboat
    ./sway
    ./kanshi.nix
    ./waybar
    ./tmux
    #./code
    ./zathura.nix
    ./ssh.nix
    ./git.nix
    ./zsh.nix
    #./foot.nix
    #./alacritty.nix
    ./kitty.nix
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

    btop
    neofetch
    onefetch

    vlc
    pavucontrol
    pulsemixer
    gimp

    discord
    signal-desktop
    teams
    libreoffice

    jdk
    jetbrains.idea-community

    #kicad

    remmina

    postman
    docker-compose_2
    mongodb-compass

    networkmanagerapplet

    polymc

    gnome3.adwaita-icon-theme

    #gnome.gnome-tweaks
    #gnomeExtensions.appindicator
    #gnomeExtensions.sound-output-device-chooser
    #gnomeExtensions.dash-to-dock
  ];
}
