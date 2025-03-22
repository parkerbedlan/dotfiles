{ pkgs, ... }:
{
  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    wireplumber = {
      enable = true;
      extraConfig = {
        "10-bluez" = {
          "monitor.bluez.properties" = {
            "bluez5.enable-sbc-xq" = true;
            "bluez5.enable-msbc" = true;
            "bluez5.enable-hw-volume" = true;
            "bluez5.headset-roles" = "[]";
            "bluez5.hfphsp-backend" = "none";
            "bluez5.autoswitch-profile" = false;
            "bluez5.default-profile" = "a2dp-sink";
            "bluez5.codecs" = [
              "sbc"
              "sbc_xq"
              "aac"
              "ldac"
              "aptx"
              "aptx_hd"
            ];
          };
        };
      };
    };
    pulse.enable = true;
    jack.enable = true;
    
    extraConfig = {
      pipewire = {
        "context.properties" = {
          "bluez5.enable-sbc-xq" = true;
          "bluez5.enable-msbc" = true;
          "bluez5.default-profile" = "a2dp-sink";
        };
      };
    };
  };

  hardware = {
    pulseaudio.support32Bit = true;

    bluetooth = {
      enable = true;
      powerOnBoot = false;
      package = pkgs.bluez5-experimental;
      settings = {
        General = {
          Enable = "Source,Sink,Media,Socket";
          Disable = "Headset,Gateway";
          AutoConnect = "true";
          FastConnectable = "true";
        };
        Policy = {
          AutoEnable = "false";
        };
      };
    };

    # idk
    enableAllFirmware = true;
  };
  
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="bluetooth", ATTR{name}=="*", RUN+="${pkgs.bluez}/bin/bluetoothctl connect %k && ${pkgs.bluez}/bin/bluetoothctl connect %k && ${pkgs.bluez}/bin/bluetoothctl connect %k"
  '';
  
  services.blueman.enable = true;

  # idk
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
}