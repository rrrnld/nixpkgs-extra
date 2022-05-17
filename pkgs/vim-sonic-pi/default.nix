{ pkgs }:
pkgs.vimUtils.buildVimPlugin {
  pname = "vim-sonic-pi";
  buildInputs = [];
  version = "0.0.1-dirty";
  src = pkgs.fetchFromGitHub {
    owner = "lilyinstarlight";
    repo = "vim-sonic-pi";
    rev = "02e947d377b757c541750ee2101022b460053cb2";
    sha256 = "sha256-S17RJMlUOP9YLc6+slifkbRza326LV/eoKshkh3ae5E=";
  };
}
