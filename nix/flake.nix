{
  description = "oat flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-colors = {
      url = "github:misterio77/nix-colors";
    };

    catppuccin-base16 = {
      url = "github:catppuccin/base16";
      flake = false;
    };
  };

  outputs = {self, ...} @ inputs:
    with import ./lib/make.nix {
      inherit inputs;
      user = "metsawyr";
      flakePath = /. + builtins.toPath self;
      system = "x86_64-linux";
    }; let
      bazelShell = pkgs.buildFHSUserEnv {
        name = "bazel-fhs";
        targetPkgs = pkgs: [
          pkgs.bazel_7
        ];
        runScript = "${pkgs.zsh}/bin/zsh";
      };
    in {
      formatter.${system} = pkgs.alejandra;

      nixosConfigurations = {
        home-wsl = mkWslSystem {
          hostname = "home";
        };
      };

      homeConfigurations = {
        # Home NixOS WSL
        "${user}@home-wsl" = mkHome {};

        # Work Ubuntu WSL
        "${user}@es-mradetskyi" = mkHome {
          extraModules = [
            #		  	./config/nix.nix
            {
              targets.genericLinux.enable = true;
            }
          ];
        };
      };

      devShells."x86_64-linux".bazel = bazelShell.env;
    };
}
