{ pkgs, ... }:
{
  home.packages = with pkgs; [
    ghidra-bin
    radare2
    ilspy

    hashcat

    nmap
    wireshark
    saleae-logic-2

    burpsuite

    pwndbg
    pwntools

    binwalk
  ];
}
