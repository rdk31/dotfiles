{
  programs.chromium = {
    enable = true;
    commandLineArgs = [ "--force-device-scale-factor=1.25" ];
    extensions = [
      { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # ublock origin
      { id = "mnjggcdmjocbbbhaepdhchncahnbgone"; } # sponsor block
      { id = "nngceckbapebfimnlniiiahkandclblb"; } # bitwarden
      { id = "ekhagklcjbdpajgpjgmbionohlpdbjgc"; } # zotero
      { id = "dbepggeogbaibhgnhhndojpepiihcmeb"; } # chromium
    ];
  };
}
