{ pkgs, ... }:
let
  pythonEnv = with pkgs; [
    (python310.withPackages (p:
      with p; [
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
        nltk

        hydra-core
        omegaconf

        jupyter
        ipykernel
        nbformat

        requests
        python-dotenv
        fastapi
        uvicorn

        pwntools

        black
        isort
      ]))
    poetry
  ];

  rustEnv = with pkgs; [
    cargo
    rustc
    rust-analyzer
    clippy
    rustfmt
    openssl.dev
    pkg-config
  ];

  pwnEnv = with pkgs; [
    ghidra-bin
    radare2
    ilspy

    hashcat

    nmap
    wireshark
    saleae-logic-2

    burpsuite

    pwndbg
    #pwntools

    binwalk
  ];

  cppEnv = with pkgs; [
    clang
    cmake

    platformio
  ];
in
{
  home.packages = with pkgs;
    [ ] ++ rustEnv
    #++ pwnEnv 
    ++ cppEnv ++ pythonEnv;
}
