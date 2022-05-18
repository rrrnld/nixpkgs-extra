{ vimUtils, janet, fetchFromGitHub }:
vimUtils.buildVimPlugin {
  pname = "janet-vim";
  buildInputs = [ janet ];
  version = "0.0.1-dirty";
  src = fetchFromGitHub {
    owner = "janet-lang";
    repo = "janet.vim";
    rev = "294538bab12a56129b8c8433ef7d23b18d05f2e9";
    sha256 = "1x81n4sdxza5hx3fg2pnzkj4f1sv87i7spldg8rsqpglx7da4clx";
  };
}
