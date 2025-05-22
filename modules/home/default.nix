{
  config,
  pkgs,
  lib,
  ...
}:

{
  imports = [
    ./aliases.nix
    ./bash.nix
    ./browser.nix
    ./git.nix
    ./obs.nix
    ./parcellite.nix
    ./stylix.nix
    ./tmux.nix
    ./xfce.nix
    ./zoxide.nix
  ];

  options = {
    host = lib.mkOption { };
  };

  config = {
    home.username = "pk";
    home.homeDirectory = "/home/pk";

    home.stateVersion = "24.11"; # do not change

    home.packages = [
      pkgs.hello
      (pkgs.writeShellScriptBin "my-hello" ''
        echo "Hello, ${config.home.username}!"
      '')
      (pkgs.writeShellScriptBin "yt" ''
        pushd ~/Music
        yt-dlp -x --audio-format mp3 https://www.youtube.com/watch?v=$1
        popd
      '')
    ];

    home.file = {
      ".inputrc".source = ./.inputrc;

      "justfile".text = ''
        home:
          tmux new-session -d -s home -n notes \; \
            send-keys 'cd ~/repos/obsidian-personal' Enter 'gp' Enter \; \
            new-window -n nixos \; \
            send-keys 'cd nixos' Enter 'gp' Enter 'v' Enter \; \
            new-window -n nixos \; \
            send-keys 'cd nixos' Enter \; \
            select-window -t home:1 \; \
            attach-session -t home
      '';
    };

    home.sessionVariables = {
      EDITOR = "nixCats";
    };

    programs.home-manager.enable = true;
  };
}
