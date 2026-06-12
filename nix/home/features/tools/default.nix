{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.dev.tools;
  inherit (lib) mkEnableOption mkIf mkMerge;

  gcloud = pkgs.google-cloud-sdk.withExtraComponents (with pkgs.google-cloud-sdk.components; [
    gke-gcloud-auth-plugin
    kubectl
  ]);
in {
  options.dev.tools = {
    bazel.enable = mkEnableOption "Bazel build tooling";
    cloud.enable = mkEnableOption "Cloud/Kubernetes tooling";
  };

  config = mkMerge [
    (mkIf cfg.bazel.enable {
      home.packages = with pkgs; [
        bazel_7
        bazel-gazelle
        bazel-buildtools
      ];

      home.file.".local/bin/bazel_gopackagesdriver.sh" = {
        source = ../../shell/bazel_gopackagesdriver.sh;
        executable = true;
      };
    })
    (mkIf cfg.cloud.enable {
      home.packages = with pkgs; [
        gcloud
        fluxcd
        minikube
      ];
    })
  ];
}
