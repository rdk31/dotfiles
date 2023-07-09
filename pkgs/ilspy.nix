{ stdenv, lib, makeWrapper, autoPatchelfHook, coreutils, libX11, libkrb5, curl
, lttng-ust, gtk3, openssl, icu, unzip, fetchurl, makeDesktopItem }:
let
  libs =
    [ libX11 stdenv.cc.cc.lib libkrb5 curl lttng-ust gtk3 openssl.out icu ];
  icon = fetchurl {
    url =
      "https://raw.githubusercontent.com/icsharpcode/AvaloniaILSpy/113ef114015d2e75309d53ccbd98a5910acaade2/ILSpy/ILSpy.ico";
    sha256 = "sha256-amBWs/JxuVaA6rFMkP4aPui9M142CRw0hD6J/lt5ViU=";
  };
  desktopItem = makeDesktopItem {
    type = "Application";
    name = "ILSpy";
    desktopName = "ILSpy";
    exec = "ILSpy";
    comment = ".NET assembly browser and decompiler";
    categories = [ "Development" ];
    icon = "ILSpy";
  };
in stdenv.mkDerivation rec {
  pname = "ilspy";
  version = "unstable-${releaseVersion}";
  releaseVersion = "7.2-rc";

  nativeBuildInputs = [ autoPatchelfHook ];

  # Crashes at startup when stripping:
  # "Failed to create CoreCLR, HRESULT: 0x80004005"
  dontStrip = true;

  # autoPatchelfHook could not satisfy dependency liblttng-ust.so.0 wanted by /nix/store/g78530fqy6mibaqlcbjgx022kwak86x6-ilspy-unstable-7.0-rc2/bin/libcoreclrtraceptprovider.so
  # everything seems to work fine without it
  autoPatchelfIgnoreMissingDeps = true;

  sourceRoot = ".";

  buildInputs = [ makeWrapper unzip ] ++ libs;

  src = fetchurl {
    url =
      "https://github.com/icsharpcode/AvaloniaILSpy/releases/download/v${releaseVersion}/linux.x64.Release.zip";
    sha256 = "sha256-rSAvazsUwF+Bv5mMjQvM045xjnWdw+iaDYE1A7ygvQg=";
  };

  installPhase = ''
    ${unzip}/bin/unzip ILSpy-linux-x64-Release.zip # a zip within a zip, I think they made a mistake packaging this
    ${coreutils}/bin/mkdir -p \
      $out/bin \
      $out/share/applications \
      $out/share/pixmaps
    ${coreutils}/bin/ln -s ${icon} $out/share/pixmaps/ILSpy.ico
    ${coreutils}/bin/mv artifacts/linux-x64/* $out/bin
    ${coreutils}/bin/chmod a+x $out/bin/ILSpy
    wrapProgram $out/bin/ILSpy \
      --prefix LD_LIBRARY_PATH : "${lib.makeLibraryPath libs}"
    ${coreutils}/bin/ln -s ${desktopItem}/share/applications/ILSpy.desktop $out/share/applications/ILSpy.desktop
  '';

  meta = with lib; {
    description = ".NET assembly browser and decompiler";
    homepage = "https://github.com/icsharpcode/AvaloniaILSpy";
    platforms = [ "x86_64-linux" ];
    license = licenses.mit;
    maintainers = with maintainers; [ mausch ];
  };
}
