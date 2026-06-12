{...}: {
  # Home NixOS WSL — full work environment (matches the pre-reorg package set).
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
