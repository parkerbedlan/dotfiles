{ pkgs, ... }:

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
  ];

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
