{ pkgs, ... }:
{
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      rocmPackages.clr.icd
      rocmPackages.rocminfo
      rocmPackages.rocm-runtime
      rocmPackages.rocm-device-libs
      rocmPackages.rocm-smi
      rocmPackages.hipcc
      rocmPackages.hipblas
      rocmPackages.rocblas
    ];
  };

  environment.sessionVariables = {
    HIP_PATH = "${pkgs.rocmPackages.hipcc}";
    ROCM_PATH = "${pkgs.rocmPackages.rocm-runtime}";
  };
}
