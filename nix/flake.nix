{
  description = "oat flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
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

	vscode-server.url = "github:nix-community/nixos-vscode-server";

    noctalia = {
      url = "github:noctalia-dev/noctalia/legacy-v4";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
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

      vulkanShell = pkgs.mkShell {
        packages = with pkgs; [
          vulkan-headers
          vulkan-loader
          vulkan-validation-layers
          vulkan-tools
          shaderc
          glfw
          pkg-config
          wayland
          wayland-protocols
          libxkbcommon
        ];

        # Force the WSLg/D3D12 ICD so we get the real GPU, not llvmpipe.
        VK_ICD_FILENAMES = "/run/opengl-driver/share/vulkan/icd.d/dzn_icd.x86_64.json";
        VK_LAYER_PATH = "${pkgs.vulkan-validation-layers}/share/vulkan/explicit_layer.d";
      };
    in {
      formatter.${system} = pkgs.alejandra;

      nixosConfigurations = {
        home-wsl = mkWslSystem {
          hostname = "home";
        };

        # Standalone Hyprland desktop.
        home = mkSystem {
          hostname = "home";
          extraModules = [./hosts/home];
        };
      };

      homeConfigurations = {
        # Home NixOS WSL
        "${user}@home-wsl" = mkHome {
          extraModules = [./home/profiles/wsl.nix];
        };

        # Work Ubuntu WSL
        "${user}@es-mradetskyi" = mkHome {
          extraModules = [./home/profiles/work.nix];
        };

        # Standalone Hyprland desktop
        "${user}@home" = mkHome {
          extraModules = [./home/profiles/home.nix];
        };
      };

      devShells."x86_64-linux".bazel = bazelShell.env;
      devShells."x86_64-linux".vulkan = vulkanShell;
    };
}
