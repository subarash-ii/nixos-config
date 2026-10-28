{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    efiInstallAsRemovable = true;
    device = "nodev";
  };

  boot.loader.efi = {
    efiSysMountPoint = "/boot";
    canTouchEfiVariables = false;
  };

  networking.hostName = "nixos-server";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Kyiv";
  i18n.defaultLocale = "en_US.UTF-8";

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  services.logind.settings.Login = {
    HandleLidSwitch = "ignore";
    HandleLidSwitchExternalPower = "ignore";
    HandleLidSwitchDocked = "ignore";
  };

  users.users.subarashii = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    hashedPassword = "$6$junTawP38GIiKLmr$KNJtZEWZefU4/9OX2htP0xP1oqo/0tCOr6gs6KZ6cKxPVpfyWpFZRHId3t2NKBQZfjiExKmhTWDf6UGxiHSyN1";
  };

  environment.systemPackages = with pkgs; [
    git
    nano
    vim
    htop
    wget
    curl
    fastfetch
  ];

  services.openssh = {
    enable = true;

    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = true;
      PubkeyAuthentication = true;
    };
  };

  networking.firewall.allowedTCPPorts = [ 22 ];
  
  system.stateVersion = "26.05";
}