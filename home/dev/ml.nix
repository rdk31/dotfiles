{ pkgs, ... }:
let
  pythonEnv = pkgs.python310.withPackages (p: with p; [
    numpy
    dask
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

    hydra-core
    omegaconf

    jupyter
    ipykernel
    nbformat
  ]);
in
{
  home.packages = with pkgs; [
    (gephi.overrideAttrs (old: rec {
      version = "0.10.1";
      src = fetchFromGitHub {
        owner = "gephi";
        repo = "gephi";
        rev = "v${version}";
        sha256 = "sha256-ZNSEaiD32zFfF2ISKa1CmcT9Nq6r5i2rNHooQAcVbn4=";
      };
      deps = stdenv.mkDerivation {
        name = "gephi-${version}-deps";
        inherit src;
        buildInputs = [ jdk maven ];
        buildPhase = ''
          while mvn package -Dmaven.repo.local=$out/.m2 -Dmaven.wagon.rto=5000; [ $? = 1 ]; do
            echo "timeout, restart maven to continue downloading"
          done
        '';
        # keep only *.{pom,jar,sha1,nbm} and delete all ephemeral files with lastModified timestamps inside
        installPhase = ''find $out/.m2 -type f -regex '.+\(\.lastUpdated\|resolver-status\.properties\|_remote\.repositories\)' -delete'';
        outputHashAlgo = "sha256";
        outputHashMode = "recursive";
        outputHash = "sha256-OdW4M5nGEkYkmHpRLM4cBQtk4SJII2uqM8TXb6y4eXk=";
      };
      buildPhase = ''
        # 'maven.repo.local' must be writable so copy it out of nix store
        mvn package --offline -Dmaven.repo.local=$(cp -dpR ${deps}/.m2 ./ && chmod +w -R .m2 && pwd)/.m2
      '';
    }))
    cytoscape
    pythonEnv
  ];
}
