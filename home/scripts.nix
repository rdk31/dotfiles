{ pkgs, ... }:
let
  wol-nixhome = pkgs.writeShellScriptBin "wol-nixhome" ''
    ${pkgs.openssh}/bin/ssh home 'nix-shell -p wol --run "wol d4:3d:7e:51:92:db"'
  '';
in
{
  home.packages = [
    wol-nixhome
  ];
}
