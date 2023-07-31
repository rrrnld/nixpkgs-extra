{
  description = "Some extra packages not present in the official nixpkgs repo while it hasn't yet eaten the world";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs { inherit system; };
      # small helper to reduce repetition
      callPkg = path: pkgs.callPackage ./pkgs/${path} {};
      # flat map containing all packages
      extraPkgs = {
        go-pmtiles = callPkg "go-pmtiles";
        imposm = callPkg "imposm";
        janet-vim = callPkg "vim-plugins/janet-vim";
        mqtt2prometheus = callPkg "mqtt2prometheus";
        nodemcu-uploader = callPkg "nodemcu-uploader";
        vim-sonic-pi = callPkg "vim-plugins/vim-sonic-pi";
      };
      # overlay that exports all packages nicely
      defaultOverlay = (final: prev: {
        vimPlugins = prev.vimPlugins // {
          janet-vim = extraPkgs.janet-vim;
          vim-sonic-pi = extraPkgs.vim-sonic-pi;
        };
        go-pmtiles = extraPkgs.go-pmtiles;
        imposm = extraPkgs.imposm;
        mqtt2prometheus = extraPkgs.mqtt2prometheus;
        nodemcu-uploader = extraPkgs.nodemcu-uploader;
      });
    in rec {
      packages = extraPkgs;
      apps = {
        mqtt2prometheus = {
          type = "app";
          program = "${extraPkgs.mqtt2prometheus}/bin/cmd";
        };
      };
      overlay = defaultOverlay;
      overlays = {
        default = defaultOverlay;
      };
    }
  );
}
