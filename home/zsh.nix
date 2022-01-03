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
    shellAliases = {
      ls = "exa";
      grep = "grep --color=auto";
    };
  };
}
