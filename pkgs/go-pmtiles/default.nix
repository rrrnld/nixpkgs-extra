{lib, fetchFromGitHub, buildGoModule}:

buildGoModule rec {
  pname = "go-pmtiles";
  version = "2.0.1";

  src = fetchFromGitHub {
    owner = "protomaps";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-gd85VB+Gjc75UdfsSjaXH2vWg+Da3uyVkVWt5KzYKcc=";
  };

  vendorSha256 = "sha256-roFmZJzw+5ieCCrUX+/Ril6KSJBgFU3nN+/ayyYNPgE=";

  meta = with lib; {
    description = "Single-file executable tool for creating, reading and uploading PMTiles archives.";
    homepage = "https://github.com/protomaps/go-pmtiles";
    license = licenses.bsd3;
    platforms = platforms.unix;
    maintainers = with maintainers; [];
  };
}
