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
      mypkgs = {
        janet-vim = pkgs.callPackage ./pkgs/vim-plugins/janet-vim/default.nix {};
        vim-sonic-pi = pkgs.callPackage ./pkgs/vim-plugins/vim-sonic-pi/default.nix {};
        gotosocial = pkgs.callPackage ./pkgs/gotosocial {};
      };
      myoverlay = (final: prev: {
        vimPlugins = prev.vimPlugins // {
          janet-vim = mypkgs.janet-vim;
          vim-sonic-pi = mypkgs.vim-sonic-pi;
        };
        gotosocial = pkgs.callPackage ./pkgs/gotosocial {};
      });
    in rec {
      packages = flake-utils.lib.flattenTree mypkgs;
      overlay = myoverlay;
      overlays = {
        heyarne = myoverlay;
      };
    }
  );
}
