{ pkgs, ... }:
let
  pythonEnv = with pkgs; [
    (python311.withPackages (
      p: with p; [
        numpy
        pandas
        matplotlib
        seaborn
        plotly
        scikit-learn
        torch
        pytorch-lightning
        torchvision
        wandb
        tqdm
        networkx
        pyvis
        graphviz
        opencv4
        scikit-image

        hydra-core
        omegaconf

        jupyter
        ipykernel
        nbformat

        requests
        python-dotenv
        fastapi
        uvicorn

        black
        isort
        uv
      ]
    ))
  ];

  cppEnv = with pkgs; [
    clang
    cmake

    platformio
  ];
in
{
  home.packages =
    with pkgs;
    [
      devenv
      lazygit
      docker-compose
    ]
    ++ cppEnv
    ++ pythonEnv;
}
