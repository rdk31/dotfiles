{ pkgs, ... }:
{
  programs.ranger = {
    enable = true;
    settings = {
      "preview_images" = true;
      "preview_images_method" = "kitty";
      "preview_script" = "~/.config/ranger/scope.sh";
      "use_preview_script" = true;
    };
  };

  home.packages = with pkgs; [
    ffmpeg-headless
    ffmpegthumbnailer # ffmpegthumbnailer
    poppler_utils # pdftotext/pdftoppm
    catdoc
  ];

  xdg.configFile."ranger/scope.sh".source = ./scope.sh;
}
