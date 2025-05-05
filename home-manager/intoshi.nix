{
  lib,
  config,
  ...
}: {
  imports = [
    ./common

    ./cli
    ./macos
  ];

  config = {
    # my hm-modules config
    roles = {
      work = true;
    };
    # hm config
    home = {
      username = "groemmer";
      homeDirectory = lib.mkDefault "/Users/${config.home.username}";
      stateVersion = lib.mkDefault "22.05";
    };
    nixpkgs.overlays = [
      # NOTE: Remove when python-mocket 3.13.5 is in unstable
      (prev: rec {
        python312 = prev.python312.override {
          packageOverrides = prev: {
            mocket = prev.mocket.overridePythonAttrs (oldAttrs: {
              disabledTests =
                oldAttrs.disabledTests
                ++ [
                  "test_httprettish_httpx_session"
                ];
            });
          };
        };
        python312Packages = python312.pkgs;
      })
    ];
  };
}
