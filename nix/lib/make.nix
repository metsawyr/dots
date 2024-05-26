{
  inputs,
  system,
  user,
  ...
}: let
  pkgs = import inputs.nixpkgs {
    inherit system;
    config.allowUnfree = true;
    overlays = builtins.attrValues (import ../overlays);
  };

  lib = pkgs.lib.extend (final: prev: {
    prev.local = {
      umport = ./umport.nix {lib = final;};
    };
  });

  mkSystem = {
    hostname,
    system ? "x86_64-linux",
    extraModules ? [],
  }:
    inputs.nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {inherit inputs lib user;};
      modules =
        [
          {
            networking.hostName = hostname;
            nixpkgs.pkgs = pkgs;
          }
          ../config/nix.nix
        ]
        ++ extraModules;
    };

  mkWslSystem = {hostname}:
    mkSystem {
      hostname = "${hostname}-wsl";
      extraModules = [../config/wsl.nix];
    };

  mkHome = {extraModules ? []}:
    inputs.home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = {inherit inputs user;};
      modules =
        [
          ../home
          {
            home = {
              username = user;
              homeDirectory = "/home/${user}";
            };
            programs.home-manager.enable = true;
          }
        ]
        ++ extraModules;
    };
in {
  inherit
    pkgs
    lib
    system
    user
    mkSystem
    mkWslSystem
    mkHome
    ;
}
