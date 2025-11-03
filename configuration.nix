{ config, lib, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "aleph0"; # Define your hostname.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.
  time.timeZone = "America/Bogota";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };
  programs.hyprland = {
	enable = true;
	withUWSM = true;
        xwayland.enable = true;
  };
  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ch1p= {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      tree
    ];
  };

  programs.firefox.enable = true;

  environment.systemPackages = with pkgs; [
    vim 
    wget
    foot
    waybar
    gcc
    qemu
    mako
    libnotify
  ];

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;
  services.displayManager.ly.enable = true;
  fonts.packages = with pkgs;[
	nerd-fonts.jetbrains-mono
  ];


  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.gc = {
	automatic = true;
        dates = "weekly";
        options = "--delete-older-than 14d";
  };
  system.stateVersion = "25.05";
}

