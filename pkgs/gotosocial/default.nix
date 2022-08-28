{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "gotosocial";
  version = "0.4.0-rc2";

  src = fetchFromGitHub {
    owner = "superseriousbusiness";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-JanTDdYQKXv1WLzCeqX0ySqORUwN/phL6Bj89xgkRQk=";
  };

  vendorSha256 = null;
  nativeBuildInputs = [];

  subPackages = [];

  meta = with lib; {
    homepage = "https://docs.gotosocial.org/";
    description = "Fast, fun, ActivityPub server, powered by Go.";
    license = licenses.agpl3;
    maintainers = [];
  };
}
