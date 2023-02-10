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
      callPkg = path: pkgs.callPackage ./pkgs/${path}/default.nix {};
      # flat map containing all packages
      extraPkgs = {
        janet-vim = callPkg "vim-plugins/janet-vim";
        nodemcu-uploader = callPkg "nodemcu-uploader";
        vim-sonic-pi = callPkg "vim-plugins/vim-sonic-pi";
        go-pmtiles = callPkg "go-pmtiles";
        mqtt2prometheus = callPkg "mqtt2prometheus";
      };
      # overlay that sorts all packages nicely
      defaultOverlay = (final: prev: {
        vimPlugins = prev.vimPlugins // {
          janet-vim = extraPkgs.janet-vim;
          vim-sonic-pi = extraPkgs.vim-sonic-pi;
        };
        nodemcu-uploader = extraPkgs.nodemcu-uploader;
        go-pmtiles = extraPkgs.go-pmtiles;
        mqtt2prometheus = extraPkgs.mqtt2prometheus;
      });
    in rec {
      packages = extraPkgs;
      overlay = defaultOverlay;
      overlays = {
        default = defaultOverlay;
      };
    }
  );
}
