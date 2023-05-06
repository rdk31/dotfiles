{ pkgs, ... }:
let
  dask-mongo = pkgs.python310Packages.buildPythonPackage rec {
    pname = "dask-mongo";
    version = "2022.5.0";
    src = pkgs.python310Packages.fetchPypi {
      inherit pname version;
      sha256 = "sha256-pQ3HGvpdgJ51AfE10aW3l28WYl0Lv19BYTaujEbu9XU=";
    };
    buildInputs = with pkgs.python310Packages; [
      pymongo
      distributed
    ];
  };

  pythonEnv = pkgs.python310.withPackages (p: with p; [
    numpy
    dask
    dask-mongo
    pandas
    pyarrow
    matplotlib
    seaborn
    plotly
    scikit-learn
    torch
    pytorch-lightning
    torchvision
    wandb
    tqdm
    ray
    networkx
    pyvis
    graphviz

    # hydra-core
    # omegaconf

    praw
    transformers

    jupyter
    ipykernel
    nbformat

    pymongo

    requests
    fastapi
    uvicorn

    pwntools

    black
    isort
  ]);
in
{
  home.packages = with pkgs; [
    # rust
    cargo
    rustc
    rust-analyzer
    clippy
    rustfmt
    openssl.dev
    pkg-config



    # pwn
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



    # cpp
    clang
    cmake

    platformio



    # python
    pythonEnv
  ];
}
