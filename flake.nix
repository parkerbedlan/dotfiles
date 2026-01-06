{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # https://nixos-and-flakes.thiscute.world/nixos-with-flakes/downgrade-or-upgrade-packages
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # https://github.com/nix-community/nur-combined/blob/main/repos/rycee/pkgs/firefox-addons/generated-firefox-addons.nix
    # nix flake show "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons"
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix.url = "github:danth/stylix";

    # todo: according to the top of the comments in the template, it may want nixpkgs-unstable instead of nixos-unstable, so keep an eye on that
    # https://github.com/BirdeeHub/nixCats-nvim/blob/main/templates/nixExpressionFlakeOutputs/default.nix
    nixCats.url = "github:BirdeeHub/nixCats-nvim";
  };

  outputs =
    { nixpkgs, nixpkgs-stable, ... }@inputs:
    let
      myNixCats = import ./modules/nvim { inherit inputs; };
      
      mkDevShell = system: let
        pkgs = nixpkgs.legacyPackages.${system};
      in pkgs.mkShell {
        buildInputs = with pkgs; [
          myNixCats.packages.${system}.nixCats
          tmux
          git
          starship
          zoxide
          just
        ];
        
        shellHook = ''
          # Set up tmux config
          mkdir -p ~/.config/tmux
          cat > ~/.config/tmux/tmux.conf << 'EOF'
          set -g escape-time 0
          set -g prefix C-a
          unbind C-b
          bind C-a send-prefix
          set -g base-index 1
          set -g default-terminal "screen-256color"
          set -g status-bg "white"
          set-option -sa terminal-overrides ",xterm-256color:RGB"
          EOF
          
          # Set up git config
          git config --global init.defaultBranch main
          git config --global core.editor nixCats
          git config --global push.autoSetupRemote true
          git config --global alias.acp '!f() { git add -A && git commit -m "$1" && git push; }; f'
          git config --global alias.as '!f() { git add -A && git status; }; f'
          git config --global alias.ds 'diff --staged'
          
          # Set environment variables
          export EDITOR=nixCats
        '';
      };
    in
    {
      nixosConfigurations.desktop = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
          pkgs-stable = import nixpkgs-stable {
            system = "x86_64-linux";
            config.allowUnfree = true;
          };
        };
        modules = [
          ./hosts/desktop/configuration.nix
          ./modules
          inputs.stylix.nixosModules.stylix
        ];
      };
      nixosConfigurations.laptop = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
          pkgs-stable = import nixpkgs-stable {
            system = "x86_64-linux";
            config.allowUnfree = true;
          };
        };
        modules = [
          ./hosts/laptop/configuration.nix
          ./modules
          inputs.stylix.nixosModules.stylix
        ];
      };

      # todo: potentially use ${pkgs.system} for both instead of hard coding the system?
      packages.x86_64-linux.default = myNixCats.packages.x86_64-linux.nixCats;
      packages.aarch64-linux.default = myNixCats.packages.aarch64-linux.nixCats;
      packages.aarch64-darwin.default = myNixCats.packages.aarch64-darwin.nixCats;
      
      devShells.x86_64-linux.default = mkDevShell "x86_64-linux";
      devShells.aarch64-linux.default = mkDevShell "aarch64-linux";
      devShells.aarch64-darwin.default = mkDevShell "aarch64-darwin";
    };
}
