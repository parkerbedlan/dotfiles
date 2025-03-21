{ config, pkgs, ... }:
{
  # https://www.youtube.com/watch?v=ljHkWgBaQWU https://stylix.danth.me/options/nixos.html
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    image = config.lib.stylix.pixel "base00";
    polarity = "dark";
  };
}
