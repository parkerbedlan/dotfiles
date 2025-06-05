{ ... }:
{
  # the keybindings are weird and save doesn't work
  # programs.ncspot = {
  #   enable = true;
  # };

  # https://github.com/aome510/spotify-player?tab=readme-ov-file#commands
  programs.spotify-player = {
    enable = true;
    keymaps = [
      {
        command = "PageSelectNextOrScrollDown";
        key_sequence = "C-d";
      }
      {
        command = "PageSelectPreviousOrScrollUp";
        key_sequence = "C-u";
      }
      {
        command = "PreviousPage";
        key_sequence = "C-o";
      }
      {
        command = "PreviousPage";
        key_sequence = "-";
      }
      {
        command = "FocusNextWindow";
        key_sequence = "C-w";
      }
      {
        command = {
          VolumeChange = {
            offset = 5;
          };
        };
        key_sequence = "up";
      }
      {
        command = {
          VolumeChange = {
            offset = -5;
          };
        };
        key_sequence = "down";
      }
    ];
  };
}
