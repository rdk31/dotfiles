{ pkgs, ...}:
let
  previewer = pkgs.writeShellScript "previewer" ''
    file=$1
    w=$2
    h=$3
    x=$4
    y=$5

    case "$(file -Lb --mime-type "$file")" in
      image/*) ${pkgs.kitty}/bin/kitty +icat --silent --transfer-mode file --place "''${w}x''${h}@''${x}x''${y}" "$file"; exit 1;;
      video/*) mediainfo "$file";;
      application/zip) als "$file";;
      text/*|*/xml) bat --terminal-width "$(($w-2))" -f "$file";;
      application/json) cat | jq -C;;
      *) ${pkgs.pistol}/bin/pistol "$file";;
    esac
  '';
  cleaner = pkgs.writeShellScript "cleaner" ''
    ${pkgs.kitty}/bin/kitty +icat --clear --silent --transfer-mode file
  '';
in {
  programs.lf = {
    enable = true;
    extraConfig = ''
      set previewer ${previewer}
      set cleaner ${cleaner}
    '';
    commands = {
      mkdir = ''$mkdir -p "$(echo $*)"'';
      mkfile = ''$touch "$(echo $*)"'';
      delete = ''
        %{{
          set -f
          echo -n "delete \"$fx\"? [y/N] "
          read ans
          [ $ans = "y" ] && rm -rf -- "$fx"
        }}
      '';
      extract = ''
        %{{
          set -f
          echo -n "extract \"$fx\"? [y/N] "
          read ans
          [ $ans = "y" ] && aunpack "$fx"
        }}
      '';
    };
    keybindings = {
      "m" = "";
      "md" = "push :mkdir<space>";
      "mf" = "push :mkfile<space>";
      "D" = "delete";
      "E" = "extract";

      "gd" = "cd ~/.dotfiles";
      "gh" = "cd ~";
      "gm" = "cd /run/media/rdk";
      "gt" = "cd ~/tmp";
      "gw" = "cd ~/work";
    };
  };

  home.packages = with pkgs; [
    mediainfo
    pistol
    atool
  ];
}
