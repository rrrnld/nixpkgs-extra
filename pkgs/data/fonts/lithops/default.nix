{ lib, fetchzip, stdenv }:

let
  pname = "lithops";
  rev = "b9f42e0f";
in fetchzip {
  name = "${pname}-font-${rev}";

  url = "https://gitlab.com/daytonamess/lithops/-/archive/${rev}/lithops-main.zip";
  sha256 = "sha256-T5ueRNio5F8HLFde+qwNRTNV698cQO6LVFnGu8dIWdw=";

  postFetch = ''
    mkdir -p $out/share/fonts/opentype/${pname}
    unzip -j $downloadedFile \*.otf  -d $out/share/fonts/opentype/${pname}
    unzip -j $downloadedFile \*.ttf  -d $out/share/fonts/truetype/${pname}
  '';

  meta = with lib; {
    description = "Lithops is a very display, very unique, very complex semi modular font.";
    homepage = "https://velvetyne.fr/fonts/lithops/";
    platforms = platforms.all;
    maintainers = with maintainers; [ heyarne ];
    license = licenses.ofl;
  };
}
