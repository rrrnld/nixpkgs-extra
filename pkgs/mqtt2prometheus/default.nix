{ buildGoModule, fetchFromGitHub, lib }:
buildGoModule rec {
  pname = "mqtt2prometheus";
  version = "0.1.7";
  
  src = fetchFromGitHub {
    owner = "hikhvar";
    repo = "mqtt2prometheus";
    rev = "v${version}";
    sha256 = "sha256-D5AO6Qsz44ssmRu80PDiRjKSxkOUe4OSm+xtvyGkdUQ=";
  };
  
  vendorHash = "sha256-5P5J1HwlOFMaGj77k4jU8uJtm0XUIqdPT9abRcvHt2s=";
  
  meta = with lib; {
    description = "MQTT to Prometheus gateway";
    homepage = "https://github.com/hikhvar/mqtt2prometheus";
    license = licenses.mit;
    maintainers = with maintainers; [];
  };
}
