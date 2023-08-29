{ stdenv, fetchFromGitHub, cmake, mpi, ghostscript, fftw, fftwFloat, fltk, xorg, libtiff, libpng }:
stdenv.mkDerivation rec {
  name = "relion-${version}";
  version = "4.0.1";

  src = fetchFromGitHub {
    owner = "3dem";
    repo = "relion";
    rev = "0b03a6f00e6912ed9f713e3e6c7d2d4e901b8e5f";
    sha256 = "sha256-v+Vo1M4LLJ++u8eXuV+f/y/TGiLI6Pt4uYDRQi03kmE=";
  };

  nativeBuildInputs = [ cmake ];

  cmakeFlags = [
    "-DFETCH_TORCH_MODELS=OFF"
  ];

  buildInputs = [
    mpi
    ghostscript
    #fftwMpi
    fftw
    fftw.dev
    fftwFloat
    fftwFloat.dev

    fltk
    xorg.libXft
    xorg.libX11
    libtiff
    libpng
  ];
}
