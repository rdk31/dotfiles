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
      device = "/dev/disk/by-uuid/63ea76c1-75b0-462a-81b3-070c4e662fa4";
      preLVM = true;
      allowDiscards = true;
    };
  };

  fileSystems."/".options = [ "noatime" "nodiratime" "discard" ];

  time.timeZone = "Europe/Warsaw";

  networking = {
    hostName = "xps";
    networkmanager.enable = true;

    useDHCP = false;
    interfaces.enp0s13f0u1u4.useDHCP = true;
    interfaces.wlp0s20f3.useDHCP = true;
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

  services.printing.enable = true;

  #sound.enable = true;
  #hardware.pulseaudio.enable = true;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };
  xdg.portal.wlr.enable = true;
  hardware.opengl.enable = true;

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
    extraGroups = [ "wheel" "video" "adm" "networkmanager" "libvirtd" "vboxusers" ];
  };
  services.getty.autologinUser = "rdk";
  environment.loginShellInit = ''
    [[ "$(tty)" == /dev/tty1 ]] && sway
  '';
  users.defaultUserShell = pkgs.zsh;

  environment.systemPackages = with pkgs; [
    vim
    git
    htop
    curl
    wget
    wireguard
    pptp
  ];
  programs.zsh.enable = true;

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 7d";
    };
    autoOptimiseStore = true;
  };

  #systemd.user.services.swayidle = {
  #  description = "Idle Manager for Wayland";
  #  documentation = [ "man:swayidle(1)" ];
  #  wantedBy = [ "sway-session.target" ];
  #  partOf = [ "graphical-session.target" ];
  #  path = [ pkgs.bash ];
  #  serviceConfig = {
  #    ExecStart = '' ${pkgs.swayidle}/bin/swayidle -w -d \
  #      timeout 300 '${pkgs.sway}/bin/swaymsg "output * dpms off"' \
  #      resume '${pkgs.sway}/bin/swaymsg "output * dpms on"'
  #    '';
  #  };
  #};


  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.05"; # Did you read the comment?
}
