{ config, ... }:
{
  programs.ghostty = {
    enable = true;
    enableBashIntegration = true;
    settings = {
      # font-size = if config.host == "desktop" then 18 else if config.host == "laptop" then 14 else null;
      font-size = if config.host == "desktop" then 18 else 14;
      # https://ghostty.org/docs/config/keybind/reference
      keybind = [
        "ctrl+v=paste_from_clipboard"
      ];
      maximize = true;
      title = "ghostty";
    };
  };
}
