{
  pkgs,
  inputs,
  ...
}:
{
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
        tab-reloader
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
        "NixOS Options" = {
          urls = [
            {
              template = "https://search.nixos.org/options";
              params = [
                {
                  name = "channel";
                  value = "unstable";
                }
                {
                  name = "query";
                  value = "{searchTerms}";
                }
              ];
            }
          ];

          icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          definedAliases = [ "@no" ];
        };
        "MyNixOS" = {
          urls = [
            {
              template = "https://mynixos.com/search";
              params = [
                {
                  name = "q";
                  value = "{searchTerms}";
                }
              ];
            }
          ];
          icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          definedAliases = [ "@nm" ];
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
          definedAliases = [ "@ng" ];
        };
        "Perplexity" = {
          urls = [
            {
              template = "https://perplexity.ai/";
              params = [
                {
                  name = "q";
                  value = "{searchTerms}";
                }
              ];
            }
          ];
          definedAliases = [ "@p" ];
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
        "Letterboxd" = {
          urls = [
            {
              template = "https://letterboxd.com/search";
              params = [
                {
                  name = "q";
                  value = "{searchTerms}";
                }
              ];
            }
          ];
          definedAliases = [ "@l" ];
        };
        "Emojis" = {
          urls = [
            {
              template = "https://emojifinder.com";
              params = [
                {
                  name = "q";
                  value = "{searchTerms}";
                }
              ];
            }
          ];
          definedAliases = [ "@e" ];
        };
      };
      search.force = true;
      search.default = "Startpage";
      search.privateDefault = "Startpage";

      bookmarks = {
        force = true;
        settings = [
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
  };
  # not sure if this actually does anything
  xdg.mimeApps.defaultApplications = {
    "text/html" = [ "librewolf.desktop" ];
    "text/xml" = [ "librewolf.desktop" ];
    "x-scheme-handler/http" = [ "librewolf.desktop" ];
    "x-scheme-handler/https" = [ "librewolf.desktop" ];
  };

  programs.chromium = {
    enable = true;
    package = pkgs.brave;
    extensions = [
      { id = "gebbhagfogifgggkldgodflihgfeippi"; }
      { id = "mnjggcdmjocbbbhaepdhchncahnbgone"; }
      { id = "mjdepdfccjgcndkmemponafgioodelna"; }
      { id = "enamippconapkdmgfgjchkhakpfinmaj"; }
    ];
    # commandLineArgs = [
    #   "--disable-features=WebRtcAllowInputVolumeAdjustment"
    # ];
  };
}
