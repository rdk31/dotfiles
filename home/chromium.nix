{
  programs.chromium = {
    enable = true;
    extensions = [
      { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # ublock origin
      { id = "nngceckbapebfimnlniiiahkandclblb"; } # bitwarden
      { id = "ekhagklcjbdpajgpjgmbionohlpdbjgc"; } # zotero
      { id = "ammjkodgmmoknidbanneddgankgfejfh"; } # 7tv
    ];
  };
}
