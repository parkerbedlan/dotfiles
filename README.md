## My NixOS dotfiles (so far)
[Why NixOS?](https://www.youtube.com/watch?v=CwfKlX3rA6E)
<br/><br/><br/>

Run my neovim configuration (in any distro) with:
```shell
nix run github:parkerbedlan/dotfiles .
```
or:
```shell
nix shell github:parkerbedlan/dotfiles
nixCats .
```
> [!TIP]
> If you don't have the `nix` cli yet, get it with this [nix-installer](https://github.com/DeterminateSystems/nix-installer) command: 
```shell
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | \
  sh -s -- install
```
