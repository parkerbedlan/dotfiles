{ ... }:
{
  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
    # options = "caps:swapescape";
  };
  services.keyd = {
    enable = true;
    keyboards.default = {
      ids = [ "*" ];
      settings = {
        main = {
          capslock = "esc";
          leftalt = "leftcontrol";
        };
        meta = {
          backspace = "C-backspace";
          left = "C-left";
          right = "C-right";
        };
      };
    };
  };
}
