{
  config,
  pkgs,
  lib,
  ...
}:
{
  imports = [ ./hardware-configuration.nix ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 1;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices = {
    root = {
      name = "root";
      device = "/dev/disk/by-uuid/be4b678c-4a53-493b-8af6-55645e4ca3d1";
      preLVM = true;
      allowDiscards = true;
    };
  };

  boot.supportedFilesystems = [ "ntfs" ];
  boot.binfmt.emulatedSystems = [
    "aarch64-linux"
    "armv6l-linux"
  ];

  boot.extraModprobeConfig = ''
    options hid_apple fnmode=2
  '';

  fileSystems."/".options = [
    "noatime"
    "nodiratime"
    "discard"
  ];

  fileSystems."/mnt/home" = {
    device = "//home/rdk";
    fsType = "cifs";
    options = [
      "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s,user,users,credentials=${config.age.secrets.smb-home.path},uid=1000,gid=100"
    ];
  };

  time.timeZone = "Europe/Warsaw";
  time.hardwareClockInLocalTime = true;

  networking = {
    hostName = "xps";
    networkmanager.enable = true;

    useDHCP = false;
  };

  fonts.enableDefaultPackages = true;

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  services = {
    logind = {
      lidSwitchExternalPower = "ignore";
      extraConfig = ''
        HandlePowerKey = ignore
      '';
    };

    printing.enable = true;

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    blueman.enable = true;

    openssh.enable = true;

    pcscd.enable = true;

    gnome.gnome-keyring.enable = true;

    upower.enable = true;
    thermald.enable = true;
    tlp.enable = true;

    fprintd.enable = lib.mkForce false;
  };

  security.rtkit.enable = true;

  xdg.portal.enable = true;
  xdg.portal.wlr.enable = true;
  xdg.portal.config.common.default = "*";

  hardware.saleae-logic.enable = true;
  hardware = {
    graphics = {
      enable = true;
      # extraPackages = with pkgs; [
      #   intel-media-driver
      #   intel-compute-runtime
      #   vaapiIntel
      #   vaapiVdpau
      #   libvdpau-va-gl
      # ];
    };

    bluetooth.enable = true;
  };

  virtualisation.docker.enable = true;

  users.users.rdk = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "video"
      "adm"
      "networkmanager"
      "docker"
      "dialout"
      "wireshark"
    ];
  };
  users.defaultUserShell = pkgs.zsh;

  environment.systemPackages = with pkgs; [
    vim
    git
    htop
    curl
    unzip
    wget

    pciutils

    wireguard-tools
    pptp

    openconnect

    cifs-utils
    sshfs

    # opencl
    clinfo
    libva-utils
    vulkan-tools
  ];
  programs.zsh.enable = true;

  services.udev.packages = with pkgs; [
    platformio-core.udev
    openocd
  ];

  nix = {
    package = pkgs.nixVersions.stable;
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs = true
      keep-derivations = true
    '';
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 7d";
    };
    settings = {
      auto-optimise-store = true;
      trusted-users = [ "@wheel" ];
      substituters = [
        "https://nix-community.cachix.org?priority=41"
        "https://numtide.cachix.org?priority=42"
        "https://attic.rdk31.com/system?priority=43"
        "https://rdk31-dotfiles.cachix.org"
        "https://colmena.cachix.org"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "numtide.cachix.org-1:2ps1kLBUWjxIneOy1Ik6cQjb41X0iXVXeHigGmycPPE="
        "system:oVWwBo4GGaK3EAoyZH3BW7gvBZZAlUrlWcHsMyUivxM="
        "rdk31-dotfiles.cachix.org-1:Q2QZ31Iw2z9r7DqzxgnXoEQ86JTU8NxCDCv5BTRcYXI="
        "colmena.cachix.org-1:7BzpDnjjH8ki2CT3f6GdOk7QAzPOl+1t3LvTLXqYcSg="
      ];
      fallback = true;
    };
  };

  services.tailscale.enable = true;
  networking.firewall.checkReversePath = "loose";

  # for thunar
  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      thunar-archive-plugin
      thunar-volman
    ];
  };
  services.gvfs.enable = true; # Mount, trash, and other functionalities
  services.tumbler.enable = true; # Thumbnail support for images
  programs.xfconf.enable = true;

  services.getty.autologinUser = "rdk";
  environment.loginShellInit = ''
    [[ "$(tty)" == /dev/tty1 ]] && sway
  '';

  services.udisks2.enable = true;
  programs.fuse.userAllowOther = true;

  security.pam.services.swaylock = {
    text = ''
      auth include login
    '';
  };
  security.polkit.enable = true;

  age.secrets.ssh-config = {
    owner = "rdk";
    file = secrets/ssh-config.age;
  };
  age.secrets.smb-home = {
    owner = "rdk";
    file = secrets/smb-home.age;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.11"; # Did you read the comment?
}
