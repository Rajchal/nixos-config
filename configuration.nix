{ config, pkgs, ... }:

{
	imports =[./hardware-configuration.nix];# Include the results of the hardware scan.

	# Bootloader.
	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;

	# Networking.
	networking.hostName = "nixos"; # Define your hostname.
	# networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

	# Configure network proxy if necessary
	# networking.proxy.default = "http://user:password@proxy:port/";	
	# networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
	# Set your time zone.
	time.timeZone = "Asia/Kathmandu";
	# Select internationalisation properties.
	i18n.defaultLocale = "en_US.UTF-8";

	# Enable Hyprland and dependencies
	programs.hyprland.enable = true;

	services.xserver.enable = true;
	services.xserver.displayManager.gdm.enable = true;
	services.xserver.displayManager.gdm.wayland = true;

	services.xserver.windowManager.hyprland.enable = true;

	# Enable CUPS to print documents.
	services.printing.enable = true;

	# Enable sound with pipewire.
	hardware.pulseaudio.enable = false;
	services.pipewire = {
		enable = true;
		pulse.enable = true;
		audio.enable = true;


	# for jack support
	jack.enable = true;


	# use the example session manager (no others are packaged yet so this is enabled by default,
	# no need to redefine it in your config for now)
	#media-session.enable = true;

	};

	# Enable touchpad support (enabled default in most desktopManager).
	services.xserver.libinput.enable = true;

	# Define a user account. Don't forget to set a password with ‘passwd’.
	users.users.rajchal = {
		isNormalUser = true;
		description = "Anjal Rajchal";
		extraGroups = [ "networkmanager" "wheel" ];
		packages = with pkgs; [
			firefox
			kitty
		];
	};

	# List packages installed in system profile. To search, run:
	# $ nix search wget
	environment.systemPackages = with pkgs; [
		wineWowPackages.full
		kitty
		winetricks
		waybar
		dunst
		rofi-wayland
		vim
		wget
		unzip
		git
		vlc
		mpv
		vscode
		python3
		librewolf
		grim
		slurp
		wl-clipboard
		swaylock
		swayidle
		nwg-look
		python3Packages.virtualenv
	];

	# Some programs need SUID wrappers, can be configured further or are
	# started in user sessions.
	# programs.mtr.enable = true;
	# programs.gnupg.agent = {
		#   enable = true;
		#   enableSSHSupport = true;
	# };


	# List services that you want to enable:

	# Enable the OpenSSH daemon.
	services.openssh.enable = true;

	# Open ports in the firewall.
	#networking.firewall.allowedTCPPorts = [ 80 443 ];
	#networking.firewall.allowedUDPPorts = [ 53 ];
	# Or disable the firewall altogether.
	# networking.firewall.enable = false;

	# This value determines the NixOS release from which the default
	# settings for stateful data, like file locations and database versions
	# on your system were taken. It‘s perfectly fine and recommended to leave
	# this value at the release version of the first install of this system.
	# Before changing this value read the documentation for this option
	# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html
	nix.settings.experimental-features = [ "nix-command" "flakes" ];
	system.stateVersion = "24.11"; # Did you read the comment?
	nixpkgs.config.allowUnfree = true;

}
