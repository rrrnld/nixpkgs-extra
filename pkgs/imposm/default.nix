{lib, fetchFromGitHub, buildGoModule, leveldb, geos}:

buildGoModule rec {
  pname = "imposm";
  version = "0.11.1";

  src = fetchFromGitHub {
    owner = "omniscale";
    repo = "${pname}3";
    rev = "v${version}";
    sha256 = "sha256-ufP617XMkNyntdjB7EMhhkSDau/8j2UP1UAPegqP1sU=";
  };

  buildInputs = [
    leveldb.dev
    geos
  ];

  vendorSha256 = null;

  # FIXME: Some tests require the network (github.com/omniscale/imposm3/import_)
  doCheck = false;

  meta = with lib; {
    description = "Imposm imports OpenStreetMap data into PostGIS";
    homepage = "https://github.com/omniscale/imposm3";
    license = licenses.asl20;
    platforms = platforms.unix;
    maintainers = with maintainers; [];
  };
}
