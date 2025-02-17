{ config, pkgs, inputs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "pk";
  home.homeDirectory = "/home/pk";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';

    ".inputrc".text = ''
      set bell-style none
      "\C-H": backward-kill-word
    '';
  };

  programs.bash = {
    enable = true;
    bashrcExtra = ''
      echo hello world 2
      alias vim='nvim'
      alias v='vim .'
      alias gp='git pull'
      alias x='git acp a'
      alias nrsf='sudo -H -E nixos-rebuild --impure switch --flake /home/pk/nixos#default'
    '';
  };

  programs.git = {
    enable = true;
    aliases = {
      acp = "!f() { git add -A && git commit -m \"$1\" && git push; }; f";
      prune-gone = "!git branch -vv | awk '/: gone]/{print $1}' | xargs git branch -d";
      cane = "commit --amend --no-edit";
      as = "!f() { git add -A && git status; }; f";
      pfwl = "push --force-with-lease";
      ds = "diff --staged";
    };
    extraConfig = {
      init = {
        defaultBranch = "main";
      };
      core = {
        editor = "nvim";
	autocrlf = "input";
      };
      user = {
	email = "parkerbedlan@gmail.com";
        name = "Parker Bedlan";
      };
    };
  };
  # programs.git.extraConfig
    # programs.git.includes.*.contents = {
      # user = {
        # email = "parkerbedlan@gmail.com";
        # name = "Parker Bedlan";
      # };
    # };

  # nixpkgs.config.allowUnfree = true;
  # nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    # "lastpass-password-manager"
  # ];
  # todo: idk if this does anything
  # nixpkgs.config.allowUnfreePredicate = _: true;
  # delete ~/.mozilla and reboot if stuff doesn't work
  programs.firefox = {
    enable = true;
    profiles.pk = {
      isDefault = true;

      settings = {
        "browser.startup.couldRestoreSession.count" = 2;
	"browser.newtabpage.enabled" = false;
	"browser.startup.homepage" = "chrome://browser/content/blanktab.html";
	"extensions.autoDisableScopes" = 0;
	# "extensions.enabledScopes" = 15;
      };

      extensions = with inputs.firefox-addons.packages."x86_64-linux"; [
        ublock-origin
        darkreader
	lastpass-password-manager
	return-youtube-dislikes
	# worth a try
	sponsorblock
	# todo: youtube unhooked
	# this seems close?
	df-youtube
	# maybe this?: remove-youtube-s-suggestions
	# maybe look into this?: tournesol
	dearrow
      ];

      search.engines = {
        "Nix Packages" = {
          urls = [{
            template = "https://search.nixos.org/packages";
            params = [
              { name = "type"; value = "packages"; }
              { name = "query"; value = "{searchTerms}"; }
            ];
          }];

          icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          definedAliases = [ "@np" ];
        };
      };
      search.force = true;

      bookmarks = [
        {
          name = "skibidi";
          url = "https://en.wikipedia.org/wiki/Skibidi_Toilet";
        }
      ];
    };
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/pk/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
