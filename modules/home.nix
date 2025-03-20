{
  config,
  pkgs,
  inputs,
  lib,
  ...
}:

{
  options = {
    host = lib.mkOption { };
  };

  config = {
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
      # https://github.com/catppuccin/xfce4-terminal
      ".local/share/xfce4/terminal/colorschemes/catppuccin-mocha.theme".text = ''
        [Scheme]
        Name=Catppuccin-Mocha
        ColorCursor=#f5e0dc
        ColorCursorForeground=#11111b
        ColorCursorUseDefault=FALSE
        ColorForeground=#cdd6f4
        ColorBackground=#1e1e2e
        ColorSelectionBackground=#585b70
        ColorSelection=#cdd6f4
        ColorSelectionUseDefault=FALSE
        TabActivityColor=#fab387
        ColorPalette=#45475a;#f38ba8;#a6e3a1;#f9e2af;#89b4fa;#f5c2e7;#94e2d5;#bac2de;#585b70;#f38ba8;#a6e3a1;#f9e2af;#89b4fa;#f5c2e7;#94e2d5;#a6adc8
      '';

      "justfile".text = ''
        home:
          tmux new-session -d -s home -n notes \; \
            send-keys 'cd notes' Enter 'gp' Enter 'v' Enter \; \
            new-window -n nixos \; \
            send-keys 'cd nixos' Enter 'gp' Enter 'v' Enter \; \
            select-window -t home:1 \; \
            attach-session -t home

      '';
    };

    xfconf.settings = {
      xfce4-terminal = {
        "misc-show-unsafe-paste-dialog" = false;
        # stylix didn't work for some reason so did it manually with https://github.com/catppuccin/xfce4-terminal
        "color-use-theme" = "Catppuccin-Mocha";
        "misc-maximize-default" = true;
      };
      xfce4-keyboard-shortcuts = {
        "commands/custom/<Super>1" = "wmctrl -s 0";
        "commands/custom/<Super>2" = "wmctrl -s 1";
        "commands/custom/<Super>3" = "wmctrl -s 2";
        "commands/custom/<Super>4" = "wmctrl -s 3";
        "commands/custom/<Super>5" = "wmctrl -s 4";
        "commands/custom/<Super>6" = "wmctrl -s 5";
        "commands/custom/<Super>7" = "wmctrl -s 6";
        "commands/custom/<Super>8" = "wmctrl -s 7";
        "commands/custom/<Super>9" = "wmctrl -s 8";
        "commands/custom/<Super>0" = "wmctrl -s 9";
        "commands/custom/<Super><Alt>1" = "librewolf";
        "commands/custom/<Super><Alt>2" = "xfce4-terminal";
        "commands/custom/<Super><Alt>3" = "discord";
        "commands/custom/<Super><Alt><Shift>3" = "whatsie";
        "commands/custom/<Super><Alt>5" = "obs";
        "commands/custom/<Super><Alt>7" = "spotify";
      };
      xfwm4 = {
        "general/workspace_count" = 10;
        "general/workspace_names" = [
          "Browser"
          "Terminal"
          "Messaging"
          "Dev Tools"
          "Video Call"
          "Workspace 6"
          "Music"
          "Workspace 8"
          "Workspace 9"
          "Gamer"
        ];
      };
      # sadly this doesn't work for some reason, so I'm doing it through the cli in my startup script
      # xfce4-panel = {
      #   "/plugins/plugin-6/hidden-legacy-items" = [ "parcellite" ];
      # };
    };

    programs.bash = {
      enable = true;
      # bashrcExtra = ''
      # '';
    };
    home.shellAliases = {
      v = "vim .";
      gp = "git pull";
      x = "git acp a";
      foo = "echo ${config.host}";
      switch = "pushd ~/nixos && git add -A && sudo -H -E nixos-rebuild --impure switch --flake /home/pk/nixos#${config.host} && popd";
      switch-d = "pushd ~/nixos && git add -A && sudo -H -E nixos-rebuild --impure switch --flake /home/pk/nixos#desktop && popd";
      switch-l = "pushd ~/nixos && git add -A && sudo -H -E nixos-rebuild --impure switch --flake /home/pk/nixos#laptop && popd";
      bluetooth = "blueman-manager";
      # https://my.nordaccount.com/dashboard/nordvpn/manual-configuration/service-credentials/
      # https://support.nordvpn.com/hc/en-us/articles/19926132780689-Manual-OpenVPN-setup-on-Android
      vpn = "tmux new-session -d -s vpn \"sudo openvpn --config /home/pk/nord/us11680.nordvpn.com.tcp.ovpn --auth-user-pass /home/pk/nord/nord-creds.txt\" \\; attach-session -t vpn";
      nd = "nix develop";
      j = "just";
      # works fine but could be refined
      cdpkg = "cd \"$(fd -H -t d . /nix/store | fzf)\"";
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
          editor = "nixCats";
          autocrlf = "input";
        };
        user = {
          email = "parkerbedlan@gmail.com";
          name = "Parker Bedlan";
        };
        push.autoSetupRemote = true;
      };
    };

    programs.librewolf = {
      enable = true;
      profiles.pk = {
        isDefault = true;

        # use about:config to try to find the ones you want
        settings = {
          # librewolf-specific
          # https://nixos.wiki/wiki/Librewolf
          "webgl.disabled" = false;
          "privacy.resistFingerprinting" = false;
          "privacy.clearOnShutdown.history" = false;
          "privacy.clearOnShutdown.cookies" = false;
          "network.cookie.lifetimePolicy" = 0;
          # set by me
          "privacy.clearOnShutdown_v2.cache" = false;
          "privacy.clearOnShutdown_v2.cookiesAndStorage" = false;

          "browser.newtabpage.enabled" = false;
          "browser.startup.homepage" = "chrome://browser/content/blanktab.html";
          "extensions.autoDisableScopes" = 0;
          "browser.toolbars.bookmarks.visibility" = "newtab";
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

          "browser.search.defaultenginename" = "Startpage";
        };

        extensions.packages = with inputs.firefox-addons.packages."x86_64-linux"; [
          ublock-origin
          darkreader
          lastpass-password-manager
          return-youtube-dislikes
          sponsorblock
          df-youtube
          dearrow
          # maybe look into this?: tournesol
        ];

        search.engines = {
          "Nix Packages" = {
            urls = [
              {
                template = "https://search.nixos.org/packages";
                params = [
                  {
                    name = "channel";
                    value = "unstable";
                  }
                  {
                    name = "type";
                    value = "packages";
                  }
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];

            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ "@np" ];
          };
          "Noogle" = {
            urls = [
              {
                template = "https://noogle.dev/q";
                params = [
                  {
                    name = "term";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            definedAliases = [ "@no" ];
          };
          "Startpage" = {
            urls = [
              {
                template = "https://www.startpage.com/do/dsearch";
                params = [
                  {
                    name = "q";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
          };
        };
        search.force = true;
        search.default = "Startpage";
        search.privateDefault = "Startpage";

        # enableBookmarks = true;
        bookmarks = [
          {
            name = "NixOS bookmarks toolbar";
            toolbar = true;
            bookmarks = [
              {
                name = "lofi";
                url = "https://music.youtube.com/watch?v=jfKfPfyJRdk";
              }
            ];
          }
          {
            name = "https://www.epochconverter.com/";
            url = "https://www.epochconverter.com/";
          }
          {
            name = "https://dateful.com/";
            url = "https://dateful.com/";
          }
          {
            name = "https://it-tools.tech/";
            url = "https://it-tools.tech/";
          }
          {
            name = "https://dashboard.twitch.tv/u/parkourbee/content/video-producer";
            url = "https://dashboard.twitch.tv/u/parkourbee/content/video-producer";
          }
          {
            name = "super secret link, do not click";
            url = "https://www.youtube.com/watch?v=dQw4w9WgXcQ";
          }
          {
            name = "audio sync test";
            url = "https://www.youtube.com/watch?v=ucZl6vQ_8Uo";
          }
        ];
      };
    };
    # not sure if this actually does anything
    xdg.mimeApps.defaultApplications = {
      "text/html" = [ "librewolf.desktop" ];
      "text/xml" = [ "librewolf.desktop" ];
      "x-scheme-handler/http" = [ "librewolf.desktop" ];
      "x-scheme-handler/https" = [ "librewolf.desktop" ];
    };

    # https://wiki.nixos.org/wiki/Zoxide
    programs.zoxide = {
      enable = true;
      enableBashIntegration = true;
      options = [ "--cmd cd" ];
    };

    programs.tmux = {
      enable = true;
      escapeTime = 0;
      prefix = "C-a";
      baseIndex = 1;
      terminal = "screen-256color";
      extraConfig = ''
        set -g status-bg "white"
        # may need slight modification? google it if it seems to not be working
        set-option -sa terminal-overrides ",xterm-256color:RGB"
        # probably redundant, but uncomment if stuff is acting weird
        # setw -g pane-base-index 1
      '';
    };

    services.parcellite = {
      enable = true;
      extraOptions = [
        "--no-icon"
      ];
    };

    stylix.enable = true;
    # idk if this is how I'm supposed to do it
    stylix.targets.librewolf.profileNames = [ "pk" ];

    programs.obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        obs-backgroundremoval
      ];
    };

    home.sessionVariables = {
      EDITOR = "nixCats";
    };

    programs.home-manager.enable = true;
  };
}
