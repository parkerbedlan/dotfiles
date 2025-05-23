# https://www.youtube.com/watch?v=qlfm3MEbqYA
{ pkgs, ... }:
{
  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true;
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
  ];
  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "/home/pk/.steam/root/compatibilitytools.d";
  };

  # todo: consider using lutris instead?
  # use bottles if still having compatibility issues, lets you run regular windows .exe files
}
