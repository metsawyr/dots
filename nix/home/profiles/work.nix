{...}: {
  # Work Ubuntu WSL — full work environment on a non-NixOS host.
  targets.genericLinux.enable = true;

  dev.langs = {
    go.enable = true;
    rust.enable = true;
    node.enable = true;
    c.enable = true;
    erlang.enable = true;
    lua.enable = true;
    nix.enable = true;
    protobuf.enable = true;
  };

  dev.tools = {
    bazel.enable = true;
    cloud.enable = true;
  };
}
