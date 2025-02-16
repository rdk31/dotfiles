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
    ./dev.nix
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

        rsync
        rclone

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
        slack
        signal-desktop
        whatsapp-for-linux

        spotify

        networkmanagerapplet

        mongodb-compass

        prismlauncher

        adwaita-icon-theme

        yubikey-manager
        yubikey-manager-qt

        zotero
        zola

        xorg.xhost

        stable.bambu-studio

        inputs.ragenix.packages.x86_64-linux.default
        inputs.nix-matlab.packages.x86_64-linux.matlab
        inputs.zen-browser.packages.x86_64-linux.default

        mosh
      ]
      (lib.mkIf (!ciBuild) [
        #kicad-small
      ])
    ]
  );

  programs.home-manager.enable = true;

  home.stateVersion = "22.11";
}
