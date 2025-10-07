{
  ...
}:
{
  services.xserver.displayManager.sessionCommands = ''
    (sleep 2 && ((sleep 5 && wmctrl -r "LibreWolf" -t 0) & (sleep 2 && wmctrl -r "ghostty" -t 1) & (librewolf & wmctrl -s 3 && ghostty -e bash -c 'just home; exec bash'))) &
    #
    # # helper: wait up to ~10s for a window title/class to appear
    # wait_for_window() {
    #   local pattern="$1"
    #   local tries=40
    #   while [ $tries -gt 0 ]; do
    #     if wmctrl -l | grep -i -- "$pattern" >/dev/null 2>&1; then
    #       return 0
    #     fi
    #     tries=$((tries-1))
    #     sleep 0.25
    #   done
    #   return 1
    # }
    #
    # # start terminal first so moving it won't race
    # ghostty -e "bash -c 'just home; exec bash'" &
    # wait_for_window "ghostty" && wmctrl -r "ghostty" -t 1 || echo "ghostty not found"
    #
    # # start LibreWolf, wait for it, move it to workspace 0
    # librewolf & 
    # wait_for_window "LibreWolf" && wmctrl -r "LibreWolf" -t 0 || echo "LibreWolf not found"
    #
    # # finally switch me to workspace 3 (0-indexed)
    # wmctrl -s 3



    xfconf-query -c xfce4-panel -p /plugins/plugin-6/hidden-legacy-items -t string -s "parcellite" -a -n
    xfconf-query -c xfce4-desktop -p /backdrop/single-workspace-number -t int -s 0 -n
    xfconf-query -c xfce4-desktop -p /backdrop/single-workspace-mode -t bool -s true -n
    #1e1e2e background
    xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitoreDP-1/workspace0/rgba1 -t double -t double -t double -t double -s 0.117647 -s 0.117647 -s 0.180392 -s 1.000000 -n
    xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitoreDP-1/workspace0/rgba2 -r
    xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitoreDP-1/workspace0/backdrop-cycle-enable -t bool -s false -n
    xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitoreDP-1/workspace0/color-style -t int -s 0 -n
  '';
}
