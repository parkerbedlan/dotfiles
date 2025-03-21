{ config, ... }:
{
  home.shellAliases = {
    v = "vim .";
    gp = "git pull";
    x = "git acp a";
    foo = "echo ${config.host}";
    switch = "pushd ~/nixos && git add -A && sudo -H -E nixos-rebuild --impure switch --flake /home/pk/nixos#${config.host} && popd";
    bluetooth = "blueman-manager";
    # https://my.nordaccount.com/dashboard/nordvpn/manual-configuration/service-credentials/
    # https://support.nordvpn.com/hc/en-us/articles/19926132780689-Manual-OpenVPN-setup-on-Android
    vpn = "tmux new-session -d -s vpn \"sudo openvpn --config /home/pk/nord/us11680.nordvpn.com.tcp.ovpn --auth-user-pass /home/pk/nord/nord-creds.txt\" \\; attach-session -t vpn";
    nd = "nix develop";
    j = "just";
    # works fine but could be refined
    cdpkg = "cd \"$(fd -H -t d . /nix/store | fzf)\"";
  };
}
