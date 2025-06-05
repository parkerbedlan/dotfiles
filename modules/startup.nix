{
  ...
}:
{
  services.xserver.displayManager.sessionCommands = ''
    (sleep 2 && ((sleep 5 && wmctrl -r "LibreWolf" -t 0) & (sleep 2 && wmctrl -i -r 0x00e00004 -t 1) & (librewolf & wmctrl -s 3 && ghostty -e "bash -c 'just home; exec bash'"))) &
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
