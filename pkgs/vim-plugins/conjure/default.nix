{ vimUtils, fetchFromGitHub, lib }:
vimUtils.buildVimPlugin {
  pname = "conjure";
  # current latest main; switches the repo to nfnl and provides an nfnl repl
  version = "2024-10-14";
  src = fetchFromGitHub {
    owner = "Olical";
    repo = "conjure";
    rev = "4c21ff7983e8669b58afafd8a7036f89b8701e06";
    sha256 = "sha256-eWo9J/j4dr1mjceP/0JVGIQrU8of0j1cmQeoWMgzyrQ=";
  };
  meta.homepage = "https://github.com/Olical/conjure/";
}
