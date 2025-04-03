# https://www.youtube.com/watch?v=qlfm3MEbqYA
# https://nixos.wiki/wiki/Steam
{ pkgs, ... }:
{
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };
  programs.gamemode.enable = true;
  # steam settings for game, Launch Options:
  # gamemoderun %command%
  # gamescope %command%

  # `protonup` needs to be run in terminal imperitively to set up
  # https://youtu.be/qlfm3MEbqYA?si=fqoZRwJ4lS41xgdF&t=363
  # then select new proton version in Compatibility settings of any steam game
  # use protondb.com to see whether a game is compatible on linux
  environment.systemPackages = with pkgs; [
    protonup
    # joycond
  ];
  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "/home/pk/.steam/root/compatibilitytools.d";
  };

  # todo: consider using lutris instead?
  # use bottles if still having compatibility issues, lets you run regular windows .exe files

  # not working yet
  # needed for my switch controller to be recognized by steam?
  # https://discourse.nixos.org/t/using-switch-controllers-on-steam-solved/16878/4?u=parkerbedlan
  hardware.steam-hardware.enable = true;
  # https://github.com/NixOS/nixpkgs/issues/101281#issuecomment-782596814
  # services.hardware.xow.enable = true;
  services.joycond.enable = true;

  boot.kernelModules = [ "hid_nintendo" ];

  # https://www.reddit.com/r/NixOS/comments/p3yd41/switch_pro_controllersteam/
  services.udev.packages = [
    ./steamcontroller-udev-rules
  ];
}
