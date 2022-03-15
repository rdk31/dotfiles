{ pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    autocd = true;
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "sudo" "docker" "systemd" "kubectl" "rsync" ];
      theme = "robbyrussell";
    };
    enableSyntaxHighlighting = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    shellAliases = {
      ls = "exa";
      grep = "grep --color=auto";
      cal = "cal -m";
    };
    initExtra = ''
      cal -m
    '';
    plugins = [
      {
        name = "zsh-nix-shell";
        file = "nix-shell.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "chisui";
          repo = "zsh-nix-shell";
          rev = "v0.4.0";
          sha256 = "037wz9fqmx0ngcwl9az55fgkipb745rymznxnssr3rx9irb6apzg";
        };
      }
    ];
  };
}
