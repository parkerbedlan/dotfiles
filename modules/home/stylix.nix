{ ... }:
{
  stylix.enable = true;
  stylix.targets.librewolf.profileNames = [ "pk" ];

  gtk.gtk3.extraConfig.gtk-application-prefer-dark-theme = true;

  dconf.settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
  dconf.settings."org/x/apps/portal".color-scheme = "prefer-dark";
}
