{ ... }:
{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.pk = {
    isNormalUser = true;
    description = "pk";
    extraGroups = [
      "networkmanager"
      "wheel"
      "vboxusers"
    ];
    # packages = with pkgs; [
    # ];
  };
}
