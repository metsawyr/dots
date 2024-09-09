{
  go = final: prev: {
    go = prev.go_1_23;
    gopls = prev.gopls.override {
      buildGoModule = prev.buildGo123Module;
    };
    golangci-lint = prev.golangci-lint.override {
      buildGoModule = prev.buildGo123Module;
    };
  };

  bazel = final: prev: let
    version = "7.3.1";
  in {
    bazel =
      (prev.bazel_7.override {
        inherit version;
      })
      .overrideAttrs (_: {
        inherit version;
        src = prev.fetchurl {
          url = "https://github.com/bazelbuild/bazel/releases/download/${version}/bazel-${version}-dist.zip";
          hash = "sha256-arznxTf+Ja9zdWB3VmGP7ZiqQaZvS682bZgWuJGGIro=";
        };
      });
  };
}
