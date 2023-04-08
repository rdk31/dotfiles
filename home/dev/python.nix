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

  datapipelines = pkgs.python310Packages.buildPythonPackage rec {
    pname = "datapipelines";
    version = "1.0.7";
    src = pkgs.python310Packages.fetchPypi {
      inherit pname version;
      sha256 = "sha256-dSvHGh4DpF1yP8TZtWxkHtC4cu0d9zsIiW7jTZPFbo8=";
    };
    buildInputs = with pkgs.python310Packages; [
      networkx
      merakicommons
      pytest
    ];
  };

  merakicommons = pkgs.python310Packages.buildPythonPackage rec {
    pname = "merakicommons";
    version = "1.0.10";
    src = pkgs.python310Packages.fetchPypi {
      inherit pname version;
      sha256 = "sha256-/Jnr4MuFxK8Ak6lFQpSty5fAeS+KjdA4mCQqskRqp34=";
    };
    buildInputs = with pkgs.python310Packages; [
      pytest
    ];

  };

  cassiopeia = pkgs.python310Packages.buildPythonPackage rec {
    pname = "cassiopeia";
    version = "5.0.3";
    src = pkgs.python310Packages.fetchPypi {
      inherit pname version;
      sha256 = "sha256-GK38gfeV+AfObmZ02lyByAHSjs9C+c6U4j/AGLaEDWM=";
    };
    buildInputs = with pkgs.python310Packages; [
      arrow
      datapipelines
      merakicommons
      requests
      pillow
      networkx
      pytest
    ];
    doCheck = false;
  };

  pythonEnv = pkgs.python310.withPackages (p: with p; [
    pymongo
    dask-mongo

    requests
    fastapi
    uvicorn

    pwntools

    black
    isort

    cassiopeia
  ]);
in
{
  home.packages = with pkgs; [
    pythonEnv
    poetry
  ];
}
