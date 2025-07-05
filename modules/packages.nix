{ pkgs, lib, ... }:

let
  myFlake = builtins.getFlake (toString /home/pk/nixos);
in
{
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    wget
    neovim
    git
    xclip
    fzf
    yt-dlp
    bluez
    blueman
    base16-schemes
    fd
    zoxide
    alarm-clock-applet
    piper
    libratbag
    wmctrl
    discord
    tmux
    # nixCats neovim config, aliased as vim
    myFlake.packages.x86_64-linux.default
    openvpn
    whatsie
    just
    obs-studio
    spotify
    librewolf
    libreoffice
    unzip
    p7zip
    imagemagick
    qbittorrent
    tor-browser
    vlc
    audacity
    anki
    neofetch
    zoom-us
    code-cursor
    httpie-desktop
    firefox
    google-chrome
    ffmpeg
    unrar-free
    imagemagick
    gthumb
    obsidian
    neovide
    # start of random rust stuff
    # https://www.youtube.com/watch?v=rWMQ-g2QDsI
    (lib.hiPrio uutils-coreutils-noprefix)
    ripgrep
    ripgrep-all
    eza
    xh
    # https://yazi-rs.github.io/docs/quick-start
    yazi
    dust
    # I don't think I need a git ui; I'm really comfy with my aliases
    # gitui
    hyperfine
    # not needed on this list, just include in nix dev shell of whatever rust project (rather than using cargo-watch)
    # bacon
    cargo-info
    rusty-man
    # https://github.com/jhspetersson/fselect?tab=readme-ov-file#examples
    fselect
    delta
    tokei
    wiki-tui
    mprocs
    presenterm
    kondo
    # todo: try out espanso
    # end of random rust stuff
  ];

  programs.bash.blesh.enable = true;
  # try bash-completion if blesh ends up getting annoying

  # wasn't working (potentially because I was using librewolf as my browser which bans http usage)
  # try firefox or chrome for this next time
  # programs.captive-browser = {
  #   enable = true;
  #   # browser = ''
  #   #   firefox http://neverssl.com
  #   # '';
  #   # interface = "wlo1";
  #   # interface = "wlp3s0";
  # };
}
