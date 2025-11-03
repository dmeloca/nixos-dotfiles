{ config, pkgs, ... }:
let
	dotfiles = "${config.home.homeDirectory}/nixos-dotfiles/config";
    	create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
    	configs = {
		hypr = "hypr";
		waybar = "waybar";
		foot = "foot";
		nvim = "nvim";
		tmux = "tmux";
		wofi = "wofi";
		mako = "mako";
    	};
in
{
	home.username = "ch1p";
	home.homeDirectory = "/home/ch1p";
	home.stateVersion = "25.05";
	programs.git = {
    		enable = true;
    		userName  = "ch1p";
    		userEmail = "melocarrillodaniel@gmail.com";
	};

	programs.bash = {
		enable = true;
		shellAliases = {
			ls = "lsd -l";
			cat = "bat";
			nrs = "sudo nixos-rebuild switch --flake /home/ch1p/nixos-dotfiles#aleph0";
		};
		profileExtra = ''
		if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
			exec uwsm start hyprland-uwsm.desktop
		fi
		'';
	};
	xdg.configFile = builtins.mapAttrs (name: subpath: {
        	source = create_symlink "${dotfiles}/${subpath}";
        	recursive = true;
	}) configs;	
	home.packages = with pkgs; [
		neovim
		wofi
		bat
		maven
		openjdk21
		p7zip
		wl-clipboard
		grim
		slurp
		tmux
		neofetch
		hyprpaper
		hyprcursor
		lsd
		hypridle
		hyprlock
		pamixer
		pavucontrol
	];

}
