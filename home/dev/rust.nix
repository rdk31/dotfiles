{ pkgs, ... }:
{
  home.packages = with pkgs; [
    cargo
    rustc
    rust-analyzer
    clippy
    rustfmt
    openssl.dev
    pkgconfig
  ];
}
