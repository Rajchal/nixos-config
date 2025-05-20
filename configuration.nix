# /etc/nixos/configuration.nix
{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  time.timeZone = "UTC";
  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "us";

  # Enable sound
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable Hyprland (Wayland compositor)
  programs.hyprland.enable = true;

  # Example user, replace with your info
  users.users.yourusername = {
    isNormalUser = true;
    description = "Your Name";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      kitty
      waybar
      firefox
      thunar
      pulseaudio
      pavucontrol
      wl-clipboard
      grim
      slurp
      swaylock
      swayidle
      rofi-wayland
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    vim
    git
    wget
  ];

  # Enable flakes and nix-command
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # NixOS version, update when upgrading
  system.stateVersion = "24.05";
}
