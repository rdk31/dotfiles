{ pkgs, ... }: {
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };
  programs.zsh = {
    enable = true;
    autocd = true;
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "sudo" "docker" "systemd" "kubectl" "rsync" ];
    };
    syntaxHighlighting.enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    shellAliases = {
      ls = "eza";
      grep = "grep --color=auto";
      cal = "cal -m";
      lg = "lazygit";
      df = "duf";
    };
    initExtra = ''
      export RUST_SRC_PATH="${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
    '';
  };
}
