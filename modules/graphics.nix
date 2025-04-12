{ pkgs, ... }:
{
  # formerly hardware.opengl
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      # intel-media-driver
      # intel-ocl
      # intel-vaapi-driver
      rocmPackages.clr.icd
    ];
  };
}
