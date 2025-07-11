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
    to_mov = ''f() { fname="''${1%.*}"; ffmpeg -i "$1" -c:v dnxhd -profile:v dnxhr_hq -c:a pcm_s16le -pix_fmt yuv422p "''${fname}.mov"; }; f'';
    sa = "eval \"$(ssh-agent -s)\" && ssh-add ~/.ssh/id_hetzner_3";
    whatsie-reset = "rm -rf ~/.local/share/org.keshavnrj.ubuntu/WhatSie/QtWebEngine";
    vim-gui = "neovide --neovim-bin /run/current-system/sw/bin/nixCats";
    vimg = "vim-gui";
    ls = "eza";
    o = "git as && git stash && gp && git stash pop && x && echo nooice";
    q = ''q() { "$@" > /dev/null 2>&1; }; q'';
  };
}
