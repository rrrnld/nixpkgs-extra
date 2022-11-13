{ stdenv, lib, fetchFromGitHub, python3Packages }:

python3Packages.buildPythonApplication rec {
  name = "nodemcu-uploader-1.0.0";

  meta = {
    description = "File manager with minimalistic curses interface";
    homepage = http://ranger.nongnu.org/;
    license = lib.licenses.mit;
    platforms = lib.platforms.unix;
  };

  src = fetchFromGitHub {
    owner = "kmpm";
    repo = "nodemcu-uploader";
    rev = "6893b4179c29ff5c12fce9a68119258514c617e0";
    sha256 = "sha256-DOv7D+Npw0DCa8VJQEdpj0NIyym98XnfvsTZ/ymjR9I=";
  };

  checkInputs = with python3Packages; [ pytest ];
  propagatedBuildInputs = with python3Packages; [ pyserial ];

}
