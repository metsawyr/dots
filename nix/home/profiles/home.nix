{
  pkgs,
  config,
  user,
  ...
}: let
  # reinstall all extensions the same way lazy does this in neovim
  codium-ext = pkgs.writeShellScriptBin "codium-ext" ''
    set -euo pipefail
    list="/home/${user}/dots/codium/extensions.txt"
    case "''${1-restore}" in
      restore) xargs -r -n1 codium --force --install-extension < "$list" ;;
      save) codium --list-extensions > "$list" ;;
      *)
        echo "usage: codium-ext [restore|save]" >&2
        exit 1
        ;;
    esac
  '';
in {
  dev.desktop.hyprland.enable = true;

  home.packages = with pkgs; [
	unstable.claude-code
	mangohud
	protonup-ng
	lutris
	bottles
	remmina
	ardour
	gdb
	codium-ext
  ];

  programs.vscodium = {
    enable = true;
    package = pkgs.vscodium-fhs;
    mutableExtensionsDir = true;
  };

  # symlink codium config files same way as neovim's plugins
  xdg.configFile = with config.lib.file; {
    "VSCodium/User/settings.json".source =
      mkOutOfStoreSymlink "/home/${user}/dots/codium/settings.json";
    "VSCodium/User/keybindings.json".source =
      mkOutOfStoreSymlink "/home/${user}/dots/codium/keybindings.json";
    "VSCodium/User/snippets".source =
      mkOutOfStoreSymlink "/home/${user}/dots/codium/snippets";
  };

  dev.langs = {
    go.enable = true;
    rust.enable = true;
    c.enable = true;
    nix.enable = true;
    lua.enable = true;
  };
}
