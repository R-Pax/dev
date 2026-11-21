{ pkgs, ... }:

pkgs.appimageTools.wrapType2 {
  pname = "vesktop";
  version = "1.7.0";

  src = pkgs.fetchurl {
    url = "https://github.com/Vencord/Vesktop/releases/download/v1.7.0/Vesktop-1.7.0-arm64.AppImage";
    hash = "sha256-9/jArZmnMD2/YTVJiGutGqiOfzgESbgWeS0hAmf1tpE=";
  };

  meta = {
    description = "Vesktop Discord client";
    homepage = "https://github.com/Vencord/Vesktop";
    platforms = [ "aarch64-linux" ];
  };
}
