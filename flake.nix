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
      extraPkgs = {
        janet-vim = pkgs.callPackage ./pkgs/vim-plugins/janet-vim/default.nix {};
        vim-sonic-pi = pkgs.callPackage ./pkgs/vim-plugins/vim-sonic-pi/default.nix {};
        gotosocial = pkgs.callPackage ./pkgs/gotosocial {};
        lithops = pkgs.callPackage ./pkgs/data/fonts/lithops {};
      };
      defaultOverlay = (final: prev: {
        vimPlugins = prev.vimPlugins // {
          janet-vim = extraPkgs.janet-vim;
          vim-sonic-pi = extraPkgs.vim-sonic-pi;
        };
        gotosocial = extraPkgs.gotosocial;

        # fonts
        lithops = extraPkgs.lithops;
      });
    in rec {
      packages = flake-utils.lib.flattenTree extraPkgs;
      overlay = defaultOverlay;
      overlays = {
        default = defaultOverlay;
      };
    }
  );
}
