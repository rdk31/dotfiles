{ inputs, ciBuild, lib, pkgs, ... }: {
  imports = [
    ./nvim
    ./sway
    ./i3status-rs.nix
    ./kanshi.nix
    ./tmux
    ./code
    ./ssh.nix
    ./git.nix
    ./zsh.nix
    ./kitty.nix
    ./lf.nix
    ./firefox.nix
    #./chromium.nix
    ./dev.nix
    ./scripts.nix
  ];

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [ wlrobs ];
  };

  home.packages = lib.mkMerge (with pkgs; [
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

      rsync
      rclone
      lftp
      #insync-v3

      xdg-utils
      dconf

      btop
      neofetch

      vlc
      pavucontrol
      pulsemixer
      networkmanagerapplet
      gimp

      discord
      signal-desktop
      #teams
      zoom-us

      jdk

      spotify

      relion

      remmina

      kdenlive

      #postman
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

      zotero

      virt-manager

      inputs.agenix.packages.x86_64-linux.default
      inputs.devenv.packages.x86_64-linux.devenv
    ]
    (lib.mkIf (!ciBuild) [
      kicad
    ])
  ]);

  programs.home-manager.enable = true;

  home.stateVersion = "22.11";
}
