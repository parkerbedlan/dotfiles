{
  ...
}:

{
  # https://nixos.wiki/wiki/Laptop
  # Disable if devices take long to unsuspend (keyboard, mouse, etc)
  powerManagement.powertop.enable = true;
  services.thermald.enable = true;

  services = {
    power-profiles-daemon.enable = false;
    tlp = {
      enable = true;
      settings = {
        # set CPU_BOOST_ON_AC to 0 if it gets too hot
        CPU_BOOST_ON_AC = 1;
        CPU_BOOST_ON_BAT = 0;
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

        # Optional helps save long term battery health
        START_CHARGE_THRESH_BAT0 = 40; # 40 and below it starts to charge
        STOP_CHARGE_THRESH_BAT0 = 80; # 80 and above it stops charging
        # 95 for travelling
        # STOP_CHARGE_THRESH_BAT0 = 95;

        # https://discourse.nixos.org/t/turn-off-autosuspend-for-usb/58933/2
        # causes wireless keyboard/mouse to turn off intermittently if autosuspend is on
        USB_AUTOSUSPEND = 0;
      };
    };
  };
  # related to USB_AUTOSUSPEND
  boot.kernelParams = [ "usbcore.autosuspend=-1" ]; # or 120 to wait two minutes, etc
  # boot.kernelParams = [ "usbcore.autosuspend=120" ];
}
