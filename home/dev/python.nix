{ pkgs, ... }:
let
  pythonEnv = pkgs.python310.withPackages (p: with p; [
    numpy
    pandas
    matplotlib
    scikit-learn

    requests
  ]);
in
{
  home.packages = with pkgs.python310Packages; [
    pythonEnv

    virtualenv
    black
    isort
  ];
}
