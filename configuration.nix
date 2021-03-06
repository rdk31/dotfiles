{ config, pkgs, lib, ... }:
{
  imports =
    [
      ./hardware-configuration.nix
    ];

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
    extraHosts = ''
    '';
  };

  fonts = {
    fonts = with pkgs; [
      nerdfonts
    ];
    enableDefaultFonts = true;
  };

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  services.logind = {
    lidSwitchExternalPower = "ignore";
    extraConfig = ''
      HandlePowerKey=ignore
    '';
  };

  services.printing.enable = true;

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

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
  services.blueman.enable = true;

  virtualisation = {
    docker.enable = true;
    #libvirtd.enable = true;
    #virtualbox.host.enable = true;
    #virtualbox.host.enableExtensionPack = true;
  };

  users.users.rdk = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "adm" "networkmanager" "docker" "libvirtd" "vboxusers" "dialout" ];
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

    # opencl
    clinfo
    libva-utils
    vulkan-tools
  ];
  programs.zsh.enable = true;

  programs.steam.enable = true;

  nix = {
    package = pkgs.nixFlakes;
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
    };
  };

  services.getty.autologinUser = "rdk";
  environment.loginShellInit = ''
    [[ "$(tty)" == /dev/tty1 ]] && sway
  '';
  programs.wshowkeys.enable = true;
  security.pam.services.swaylock = {
    text = ''
      auth include login
    '';
  };

  services.pcscd.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It???s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.11"; # Did you read the comment?
}
