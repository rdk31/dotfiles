{
  inputs,
  ciBuild,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./nvim.nix
    ./sway
    ./i3status-rs.nix
    ./kanshi.nix
    ./tmux.nix
    ./code
    ./ssh.nix
    ./git.nix
    ./zsh.nix
    ./kitty.nix
    #./lf.nix
    ./ranger
    ./firefox.nix
    ./chromium.nix
    #./dev.nix
    ./scripts.nix
  ];

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [ wlrobs ];
  };

  xdg.configFile."matlab/nix.sh".text = ''
    INSTALL_DIR=$HOME/.local/share/matlab
  '';

  home.packages = lib.mkMerge (
    with pkgs;
    [
      [
        eza
        bat
        ripgrep
        bc
        jq
        atool
        file
        bind
        killall
        usbutils
        duf
        tldr

        nix-du

        rsync
        rclone
        lftp
        #insync-v3

        gdown
        yt-dlp

        xdg-utils
        dconf

        btop

        vlc
        pavucontrol
        pulsemixer
        networkmanagerapplet

        gimp
        pinta
        blender
        geeqie

        libreoffice

        (discord.override {
          withOpenASAR = true;
          withVencord = true;
        })
        vesktop
        signal-desktop
        teams-for-linux
        zoom-us

        jdk

        spotify

        remmina

        kdenlive

        #postman
        docker-compose

        mongodb-compass
        mongodb-tools

        networkmanagerapplet

        prismlauncher

        adwaita-icon-theme

        anki-bin

        yubikey-manager
        yubikey-manager-qt

        lazygit

        openrocket

        zotero
        zola

        obsidian

        virt-manager

        xorg.xhost

        bambu-studio
        orca-slicer
        lychee-slicer
        freecad

        inputs.ragenix.packages.x86_64-linux.default
        inputs.nix-matlab.packages.x86_64-linux.matlab
        devenv

        python3

        platformio

        mosh
      ]
      (lib.mkIf (!ciBuild) [
        kicad-small
        #relion
      ])
    ]
  );

  programs.home-manager.enable = true;

  home.stateVersion = "22.11";
}
