{ pkgs, ... }: {
  home.packages = with pkgs; [
    clang
    cmake

    platformio
  ];
}
