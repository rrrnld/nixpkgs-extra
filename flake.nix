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
    in rec {
      packages = flake-utils.lib.flattenTree {
        vim-sonic-pi = pkgs.callPackage ./pkgs/vim-sonic-pi/default.nix {};
      };
      overlay = final: prev: {
        vimPlugins = prev.vimPlugins // {
          vim-sonic-pi = packages.vim-sonic-pi;
        };
      };
    }
  );
}
