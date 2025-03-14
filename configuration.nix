# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  config,
  pkgs,
  inputs,
  ...
}:

let
  myFlake = builtins.getFlake (toString /home/pk/nixos);
in
{
  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.default
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the XFCE Desktop Environment.
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.displayManager.sessionCommands = ''
    (sleep 2 && ((sleep 5 && wmctrl -r "LibreWolf" -t 0) & (librewolf & wmctrl -s 1 && xfce4-terminal -e "bash -c 'just home; exec bash'"))) &
    xfconf-query -c xfce4-panel -p /plugins/plugin-6/hidden-legacy-items -t string -s "parcellite" -a -n
    xfconf-query -c xfce4-desktop -p /backdrop/single-workspace-number -t int -s 0 -n
    xfconf-query -c xfce4-desktop -p /backdrop/single-workspace-mode -t bool -s true -n
    #1e1e2e background
    xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitoreDP-1/workspace0/rgba1 -t double -t double -t double -t double -s 0.117647 -s 0.117647 -s 0.180392 -s 1.000000 -n
    xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitoreDP-1/workspace0/rgba2 -r
    xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitoreDP-1/workspace0/backdrop-cycle-enable -t bool -s false -n
    xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitoreDP-1/workspace0/color-style -t int -s 0 -n
  '';
  services.xserver.desktopManager.xfce.enable = true;
  programs.xfconf.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
    options = "caps:swapescape";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # gaming mouse
  services.ratbagd.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;
  services.libinput.touchpad.naturalScrolling = true;
  # use this to change touchpad scroll speed services.libinput.touchpad.accelPointsScroll

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.pk = {
    isNormalUser = true;
    description = "pk";
    extraGroups = [
      "networkmanager"
      "wheel"
      "vboxusers"
    ];
    packages = with pkgs; [
      #  thunderbird
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
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
    vlc
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "pk" = import ./home.nix;
    };
    backupFileExtension = "backup";
  };

  # https://www.youtube.com/watch?v=ljHkWgBaQWU https://stylix.danth.me/options/nixos.html
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    image = config.lib.stylix.pixel "base00";
    polarity = "dark";
  };

  environment.variables = {
    EDITOR = "nixCats";
    NIXPKGS_ALLOW_UNFREE = 1;
    LANG = "en_US.UTF-8";
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
