# https://codeberg.org/jeyj0/dotfiles/src/branch/main/packages/lychee-slicer/default.nix
{
  lib,
  stdenv,
  pkgs,
  appimageTools,
  makeDesktopItem,
  copyDesktopItems,
  gsettings-desktop-schemas,
  gtk3,
  fetchurl,
  ...
}:
let
  version = "6.0.2";
  appImage = fetchurl {
    url = "https://mango-lychee.nyc3.cdn.digitaloceanspaces.com/LycheeSlicer-${version}.AppImage";
    sha256 = "sha256-UY4EbBqiEDc9iokqWXc30ywxF9sAytfXQrtPrvWwMXY=";
  };
in
appimageTools.wrapType2 {
  pname = "lychee-slicer";
  inherit version;

  src = appImage;

  nativeBuildInputs = [ copyDesktopItems ];

  profile = ''
    export LC_ALL=C.UTF-8
    export XDG_DATA_DIRS="${gsettings-desktop-schemas}/share/gsettings-schemas/${gsettings-desktop-schemas.name}:${gtk3}/share/gsettings-schemas/${gtk3.name}:$XDG_DATA_DIRS"
  '';

  extraPkgs =
    pkgs:
    (appimageTools.defaultFhsEnvArgs.multiPkgs pkgs)
    ++ (with pkgs; [
      # fixes "unexpected error"
      gsettings-desktop-schemas
      glib
      gtk3

      # needed for icons
      adwaita-icon-theme
    ]);

  # desktopItems = [
  #   (makeDesktopItem {
  #     name = "Lychee Slicer";
  #     exec = "lychee-slicer";
  #     icon = "lychee-slicer";
  #     desktopName = "Lychee Slicer";
  #   })
  # ];

  meta = with lib; {
    description = "Lychee Slicer";
    homepage = "https://mango3d.io/";
  };
}
