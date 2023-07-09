{ config, pkgs, lib, ... }: {
  imports = [ ./hardware-configuration.nix ];

  boot.loader.systemd-boot.enable = true;
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

  boot.extraModprobeConfig = ''
    options hid_apple fnmode=2
  '';

  fileSystems."/".options = [ "noatime" "nodiratime" "discard" ];

  time.timeZone = "Europe/Warsaw";
  time.hardwareClockInLocalTime = true;

  networking = {
    hostName = "xps";
    networkmanager.enable = true;

    useDHCP = false;
    extraHosts = "";
  };

  #nixpkgs.config.packageOverrides = pkgs: rec {
  #  wpa_supplicant = pkgs.wpa_supplicant.overrideAttrs (attrs: {
  #    #patches = attrs.patches ++ [ ./eduroam.patch ];
  #    #extraConfig = builtins.replaceStrings [ "CONFIG_TLSV11=y" "CONFIG_TLSV12=y" ] [ "CONFIG_TLSV11=n" "CONFIG_TLSV12=n" ] attrs.extraConfig;
  #    extraConfig = attrs.extraConfig + ''
  #      undefine CONFIG_TLSV11
  #      undefine CONFIG_TLSV12
  #    '';
  #  });
  #};

  fonts = {
    fonts = with pkgs; [ nerdfonts ];
    enableDefaultFonts = true;
  };

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
  };

  security.rtkit.enable = true;

  xdg.portal.enable = true;
  xdg.portal.wlr.enable = true;

  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-compute-runtime
      vaapiIntel
      vaapiVdpau
      libvdpau-va-gl
    ];
  };

  hardware.bluetooth.enable = true;
  programs.wshowkeys.enable = true;

  virtualisation = {
    docker.enable = true;
    libvirtd.enable = true;
    virtualbox.host.enable = true;
    #virtualbox.host.enableExtensionPack = true;
  };

  users.users.rdk = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "video"
      "adm"
      "networkmanager"
      "docker"
      "libvirtd"
      "vboxusers"
      "dialout"
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

    wireguard-tools
    pptp

    cifs-utils

    # opencl
    clinfo
    libva-utils
    vulkan-tools
  ];
  programs.zsh.enable = true;

  services.udev.packages = with pkgs; [ saleae-logic-2 ];

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
      substituters =
        [ "https://rdk31-dotfiles.cachix.org" "https://colmena.cachix.org" ];
      trusted-public-keys = [
        "rdk31-dotfiles.cachix.org-1:Q2QZ31Iw2z9r7DqzxgnXoEQ86JTU8NxCDCv5BTRcYXI="
        "colmena.cachix.org-1:7BzpDnjjH8ki2CT3f6GdOk7QAzPOl+1t3LvTLXqYcSg="
      ];
    };
  };

  services.tailscale.enable = true;
  networking.firewall.checkReversePath = "loose";

  services.getty.autologinUser = "rdk";
  environment.loginShellInit = ''
    [[ "$(tty)" == /dev/tty1 ]] && sway
  '';

  services.udisks2.enable = true;

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

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.11"; # Did you read the comment?
}

