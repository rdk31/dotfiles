{ pkgs, ... }:
{
  programs.firefox = {
    enable = true;
    profiles.default = {
      settings = {
        "signon.rememberSignons" = false;
        "privacy.webrtc.legacyGlobalIndicator" = false;
        "privacy.webrtc.hideGlobalIndicator" = true;
      };
    };
  };
}
