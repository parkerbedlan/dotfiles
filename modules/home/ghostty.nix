{ config, ... }:
{
  programs.ghostty = {
    enable = true;
    enableBashIntegration = true;
    # https://ghostty.org/docs/config/reference
    settings = {
      # font-size = if config.host == "desktop" then 18 else if config.host == "laptop" then 14 else null;
      font-size = if config.host == "desktop" then 18 else 14;
      # https://ghostty.org/docs/config/keybind/reference
      keybind = [
        "ctrl+v=paste_from_clipboard"
        ''shift+enter=text:\n''
      ];
      maximize = true;
      title = "ghostty";
      # default already?
      copy-on-select = "clipboard";
      app-notifications = "no-clipboard-copy";
    };
  };
}
