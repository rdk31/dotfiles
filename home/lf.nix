{ pkgs, ... }:
let
  previewer = pkgs.writeShellScript "previewer" ''
    file=$1
    w=$2
    h=$3
    x=$4
    y=$5

    case "$(file -Lb --mime-type "$file")" in
      image/*) kitty +kitten icat --silent --stdin no --transfer-mode file --place "''${w}x''${h}@''${x}x''${y}" "$file" < /dev/null > /dev/tty; exit 1;;
      video/*) mediainfo "$file";;
      application/zip) als "$file";;
      text/*|*/xml) bat --terminal-width "$(($w-2))" -f "$file";;
      application/json) cat "$file" | jq -C;;
      *) pistol "$file";;
    esac
  '';
  cleaner = pkgs.writeShellScript "cleaner" ''
    kitty +kitten icat --clear --stdin no --silent --transfer-mode file < /dev/null > /dev/tty
  '';
in
{
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
          [ $ans = "y" ] && rm -rf $fx
        }}
      '';
      extract = ''
        %{{
          set -f
          echo -n "extract \"$fx\"? [y/N] "
          read ans
          [ $ans = "y" ] && aunpack $fx
        }}
      '';
      open = ''
        ''${{
          case $(file --mime-type "$(readlink -f $f)" -b) in
            text/*) $EDITOR $fx;;
            # application/pdf) zathura $fx >/dev/null 2>&1 ;;
            *) for f in $fx; do xdg-open $f > /dev/null 2> /dev/null & done;;
          esac
        }}
      '';
    };
    keybindings = {
      "m" = "";
      "md" = "push :mkdir<space>";
      "mf" = "push :mkfile<space>";
      "D" = "delete";
      "E" = "extract";
      "S" = "$$SHELL";

      "gd" = "cd ~/Downloads";
      "gh" = "cd ~";
      "gm" = "cd /run/media/rdk";
      "gt" = "cd ~/tmp";
      "gw" = "cd ~/work";
    };
  };

  home.packages = with pkgs; [ mediainfo pistol atool ];
}
