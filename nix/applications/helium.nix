{ lib, appimageTools, fetchurl }:

let
  pname = "helium";
  version = "0.22.1.1";

  src = fetchurl {
    url = "https://github.com/imputnet/helium-linux/releases/download/${version}/helium-${version}-arm64.AppImage";
    hash = "sha256-4+BJ/cFfHDsYU+azrOvuXIjbC7hnJ2q0DFj1ulR5TQs=";
  };
in
appimageTools.wrapType2 {
  inherit pname version src;

  meta = {
    description = "Helium web browser";
    homepage = "https://helium.computer/";
    platforms = [ "aarch64-linux" ];
    mainProgram = "helium";
  };
}
