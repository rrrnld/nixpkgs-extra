{lib, fetchFromGitHub, buildGoModule}:

buildGoModule rec {
  pname = "go-pmtiles";
  version = "1.6.2";

  src = fetchFromGitHub {
    owner = "protomaps";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-O6CvBSkOPcJ/zaY/IyKRQfTT/MUPdiCa//7b5PkDRGE=";
  };

  vendorSha256 = "sha256-0hycEEOu4E8U+B/7RFG0gdBcmR3/4xPc5GjJTGou0Ns=";

  meta = with lib; {
    description = "Single-file executable tool for creating, reading and uploading PMTiles archives ";
    homepage = "https://github.com/protomaps/go-pmtiles";
    license = licenses.bsd3;
    platforms = platforms.unix;
    maintainers = with maintainers; [];
  };
}
