# Heyarne's Nixpkgs

This repository contains a flake with some custom tools that are not included in the [official nixpkgs repository](https://github.com/NixOS/nixpkgs/).

## How to use

You need nix, here is a [guide on how to set it up](https://nixos.org/download.html#download-nix). Make sure to add

```
experimental-features = nix-command flakes
```

to your `~/.config/nix/nix.conf`. If you need more information, [here is a good blogpost](https://christine.website/blog/nix-flakes-1-2022-02-21) about Nix flakes.

After setting everything up, you can use it like you would any other flake. To run [`sonic-pi-tool`](https://github.com/emlyn/sonic-pi-tool) for example, execute

``` bash
nix run github:heyarne/nixpkgs#sonic-pi-tool
```

There is also an overlay which can be used to expose all packages in your package tree.
