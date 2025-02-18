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

    ".config/xfce4/terminal/accels.scm".text = ''
      (gtk_accel_path "<Actions>/terminal-window/paste" "<Primary>v")
      (gtk_accel_path "<Actions>/terminal-window/next-tab" "<Primary>Tab")
      (gtk_accel_path "<Actions>/terminal-window/prev-tab" "<Primary><Shift>ISO_Left_Tab")
    '';

    ".config/xfce4/xfconf/xfce-perchannel-xml/xfce4-terminal.xml".text = ''
      <?xml version="1.1" encoding="UTF-8"?>

      <channel name="xfce4-terminal" version="1.0">
        <property name="misc-show-unsafe-paste-dialog" type="bool" value="false"/>
      </channel>
    '';
  };

  programs.bash = {
    enable = true;
    bashrcExtra = ''
      alias vim='nvim'
      alias v='vim .'
      alias gp='git pull'
      alias x='git acp a'
      alias switch='sudo -H -E nixos-rebuild --impure switch --flake /home/pk/nixos#default'
      alias nrsf='switch'
      alias bluetooth='blueman-manager'
      alias blue='bluetooth'
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
      push.autoSetupRemote = true;
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
	# this doesn't seem to do anything?
        # "browser.startup.couldRestoreSession.count" = 2;
	"browser.newtabpage.enabled" = false;
	"browser.startup.homepage" = "chrome://browser/content/blanktab.html";
	"extensions.autoDisableScopes" = 0;
	"browser.toolbars.bookmarks.visibility" = "never";
	"browser.startup.page" = 3;
	# uhh no need for this one probably
	# "extensions.enabledScopes" = 15;

	# https://github.com/Misterio77/nix-config/blob/main/home/gabriel/features/desktop/common/firefox.nix
	# Disable fx accounts
        "identity.fxaccounts.enabled" = false;
        # Disable "save password" prompt
        "signon.rememberSignons" = false;
        # Harden
        "privacy.trackingprotection.enabled" = true;
        "dom.security.https_only_mode" = true;
	# Disable irritating first-run stuff
        "browser.disableResetPrompt" = true;
        "browser.download.panel.shown" = true;
        "browser.feeds.showFirstRunUI" = false;
        "browser.messaging-system.whatsNewPanel.enabled" = false;
        "browser.rights.3.shown" = true;
        "browser.shell.checkDefaultBrowser" = false;
        "browser.shell.defaultBrowserCheckCount" = 1;
        "browser.startup.homepage_override.mstone" = "ignore";
        "browser.uitour.enabled" = false;
        "startup.homepage_override_url" = "";
        "trailhead.firstrun.didSeeAboutWelcome" = true;
        "browser.bookmarks.restore_default_bookmarks" = false;
        "browser.bookmarks.addedImportButton" = true;
	# Disable some telemetry
        "app.shield.optoutstudies.enabled" = false;
        "browser.discovery.enabled" = false;
        "browser.newtabpage.activity-stream.feeds.telemetry" = false;
        "browser.newtabpage.activity-stream.telemetry" = false;
        "browser.ping-centre.telemetry" = false;
        "datareporting.healthreport.service.enabled" = false;
        "datareporting.healthreport.uploadEnabled" = false;
        "datareporting.policy.dataSubmissionEnabled" = false;
        "datareporting.sessions.current.clean" = true;
        "devtools.onboarding.telemetry.logged" = false;
        "toolkit.telemetry.archive.enabled" = false;
        "toolkit.telemetry.bhrPing.enabled" = false;
        "toolkit.telemetry.enabled" = false;
        "toolkit.telemetry.firstShutdownPing.enabled" = false;
        "toolkit.telemetry.hybridContent.enabled" = false;
        "toolkit.telemetry.newProfilePing.enabled" = false;
        "toolkit.telemetry.prompted" = 2;
        "toolkit.telemetry.rejected" = true;
        "toolkit.telemetry.reportingpolicy.firstRun" = false;
        "toolkit.telemetry.server" = "";
        "toolkit.telemetry.shutdownPingSender.enabled" = false;
        "toolkit.telemetry.unified" = false;
        "toolkit.telemetry.unifiedIsOptIn" = false;
        "toolkit.telemetry.updatePing.enabled" = false;

	# https://github.com/gvolpe/nix-config/blob/6feb7e4f47e74a8e3befd2efb423d9232f522ccd/home/programs/browsers/firefox.nix
	"browser.urlbar.quickactions.enabled" = false;
        "browser.urlbar.quickactions.showPrefs" = false;
        "browser.urlbar.shortcuts.quickactions" = false;
        "browser.urlbar.suggest.quickactions" = false;
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
  xdg.mimeApps.defaultApplications = {
    "text/html" = ["firefox.desktop"];
    "text/xml" = ["firefox.desktop"];
    "x-scheme-handler/http" = ["firefox.desktop"];
    "x-scheme-handler/https" = ["firefox.desktop"];
  };

  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
    options = ["--cmd cd"];
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
