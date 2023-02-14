{ pkgs, ... }:
let
  pythonEnv = pkgs.python310.withPackages (p: with p; [
    numpy
    pandas
    matplotlib
    scikit-learn
    tqdm
    ray

    requests
    fastapi
    uvicorn

    pwntools

    black
    isort

    ipykernel
  ]);
in
{
  home.packages = with pkgs; [
    pythonEnv
    poetry
  ];
}
