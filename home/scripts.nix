{ pkgs, ... }:
let
  wol-bayes = pkgs.writeShellScriptBin "wol-bayes" ''
    ${pkgs.openssh}/bin/ssh home 'nix-shell -p wol --run "wol d4:3d:7e:51:92:db"'
  '';
in { home.packages = [ wol-bayes ]; }
