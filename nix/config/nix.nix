{
  inputs,
  pkgs,
  user,
  ...
}: {
  system.stateVersion = "24.05";

  imports = [inputs.home-manager.nixosModules.home-manager];

  programs.zsh.enable = true;
  users.users.${user} = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = ["docker"];
  };

  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
    autoPrune.enable = true;
  };

	#  services.xserver = {
	# enable = true;
	# displayManager.gdm = {
	#   enable = true;
	#   wayland = true;	
	# };
	# windowManager.hypr.enable = true;
	#  };

  systemd.targets.user-daemon = {
    wants = [ "user@${user}.service" ];
    wantedBy = [ "multi-user.target" ];
  };

  nix = {
    settings = {
      trusted-users = [user];
      show-trace = true;
      log-lines = 1000;

      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };

    registry = {
      self.flake = inputs.self;
      nixpkgs.flake = inputs.nixpkgs;
    };

    gc = {
      automatic = true;
      options = "--delete-older-than 7d";
    };
  };
}
