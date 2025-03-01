{
  # config,
  # lib,
  # pkgs,
  ...
}:

{
  # Override the home-manager nixpkgs to patch the librewolf module
  nixpkgs.overlays = [
    (final: prev: {
      home-manager = prev.home-manager.overrideAttrs (old: {
        patches = (old.patches or [ ]) ++ [
          (final.writeText "enable-librewolf-bookmarks.patch" ''
            diff --git a/modules/programs/librewolf.nix b/modules/programs/librewolf.nix
            index xxxxxxx..xxxxxxx 100644
            --- a/modules/programs/librewolf.nix
            +++ b/modules/programs/librewolf.nix
            @@ -22,7 +22,7 @@ in {
                 platforms.darwin = {
                   configPath = "Library/Application Support/LibreWolf";
                 };
            -    enableBookmarks = false;
            +    enableBookmarks = true;
               })
             ];
          '')
        ];
      });
    })
  ];
}
