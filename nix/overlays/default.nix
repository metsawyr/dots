{
  go = final: prev: {
    go = prev.go_1_23;
    gopls = prev.gopls.override {
      buildGoModule = prev.buildGo123Module;
    };
    # golangci-lint = prev.golangci-lint.override {
    #   buildGoModule = prev.buildGo123Module;
    # };
  };

  # bazel = final: prev: let
  #   version = "7.3.1";
  # in {
  #   bazel =
  #     (prev.bazel_7.override {
  #       inherit version;
  #     })
  #     .overrideAttrs (_: {
  #       inherit version;
  #       src = prev.fetchurl {
  #         url = "https://github.com/bazelbuild/bazel/releases/download/${version}/bazel-${version}-dist.zip";
  #         hash = "sha256-8FAfkMn8dM1pM9vcWeF7jWJy1sCfi448QomFxYlxR8c=";
  #       };
  #     });
  # };

	#  meson = final: prev: {
	#    meson = prev.meson.overrideAttrs (oldAttrs: rec {
	#   version = "1.6.1";
	#      src = final.fetchFromGitHub {
	#        owner = "mesonbuild";
	#        repo = "meson";
	#        tag = version;
	#        hash = "sha256-t0JItqEbf2YqZnu5mVsCO9YGzB7WlCfsIwi76nHJ/WI=";
	#      };
	#    });
	#  };
	#
	#  libqmi = final: prev: {
	# libqmi = prev.libqmi.override {
	#      meson = prev.buildPackages.meson.overrideAttrs {
	#        src = final.fetchFromGitHub {
	#          owner = "mesonbuild";
	#          repo = "meson";
	#          tag = "1.6.1";
	#          hash = "sha256-t0JItqEbf2YqZnu5mVsCO9YGzB7WlCfsIwi76nHJ/WI=";
	#        };
	#      };
	#    };
	#  };
}
