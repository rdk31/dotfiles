{ pkgs, ... }:
let
  pythonEnv = with pkgs.stable; [
    (python311.withPackages (
      p: with p; [
        numpy
        pandas
        matplotlib
        seaborn
        plotly
        scikit-learn
        torch
        lightning
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
        #rootutils

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
    saleae-logic-2
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
