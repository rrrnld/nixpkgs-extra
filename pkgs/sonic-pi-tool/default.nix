{
  config,
  lib,
  stdenv,
  fetchFromGitHub,
  jack2,
  makeWrapper,
  python3,
  ruby,
  sonic-pi,
  supercollider-with-sc3-plugins
}:
# with (import <nixpkgs> ){};
let
  # see https://github.com/NixOS/nixpkgs/blob/master/doc/languages-frameworks/python.section.md for details
  oscpy = python3.pkgs.buildPythonPackage rec {
    pname = "oscpy";
    version = "0.6.0";
    src = python3.pkgs.fetchPypi {
      inherit pname version;
      sha256 = "sha256-ByilpyZnMsnWRjAGPThJEdXWrkdEFrebeNSQV3P7bTM=";
    };

    dontCheck = true;

    meta = {
      homepage = "https://github.com/kivy/oscpy";
      description = "An efficient OSC implementation compatible with python2.7 and 3.5+";
    };
  };
  pythonWithPackages = python3.withPackages(ps: [
      ps.click 
      ps.psutil
      oscpy
  ]);
in stdenv.mkDerivation rec {
  name = "sonic-pi-tool";
  version = "0.0.1";

  buildInputs = [
    pythonWithPackages
    ruby
  ];
  nativeBuildInputs = [
    makeWrapper
  ];

  src = fetchFromGitHub {
    owner = "emlyn";
    repo = name;
    rev = "b955369294b7669b2706b26d388ec2c2a9d0d3a2";
    sha256 = "sha256-HgJSZGjm0Uwu2TTgv/FMTRKLUdT8ILNaiL4wKJ1RyBs=";
  };

  meta = with lib; {
    description = "Controlling Sonic Pi from the command line, in Python.";
    homepage = "https://github.com/emlyn/sonic-pi-tool";
    license = licenses.mpl20;
    maintainers = [];
  };

  installPhase = ''
    mkdir -p $out/bin
    cp ${src}/sonic-pi-tool.py $out/bin/sonic-pi-tool
    chmod +x $out/bin/sonic-pi-tool
  '';

  dontPatchShebangs = true;
  preFixup = ''
    echo "Fixing shebang"
    sed -i 1d $out/bin/sonic-pi-tool
    sed -i '1i #!/usr/bin/env ${pythonWithPackages}/bin/python' $out/bin/sonic-pi-tool
    echo "Fixing sonic-pi path"
    sed -E -i "s|default_paths = \(.*$|default_paths = (\'${sonic-pi}/app\',|" $out/bin/sonic-pi-tool
    echo "Fixing ruby path"
    sed -E -i "s|ruby_paths = \[.*$|ruby_paths = [\'${ruby}/bin/ruby\',|" $out/bin/sonic-pi-tool
  '';

  doDist = true;
  distPhase = ''
    wrapProgram $out/bin/sonic-pi-tool $wrapperfile --prefix PATH : ${lib.makeBinPath [ jack2 ruby supercollider-with-sc3-plugins ]}
  '';
}
