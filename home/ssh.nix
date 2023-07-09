{ config, ... }: {
  programs.ssh = {
    enable = true;
    matchBlocks = {
      "bayes" = {
        hostname = "bayes";
        user = "rdk";
      };
    };
    extraConfig = ''
      Include /run/agenix/ssh-config
    '';
  };

}
