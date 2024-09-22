{ config, pkgs, ... }:
{
	programs.firefox = {
    enable = true;
		package = pkgs.firefox-devedition; # Higher version needed for github-refined

		# Refer to https://mozilla.github.io/policy-templates or `about:policies#documentation` in firefox
		policies = {
			AppAutoUpdate = false; # Disable automatic application update
			BackgroundAppUpdate = false; # Disable automatic application update in the background, when the application is not running.
			BlockAboutAddons = false;
			BlockAboutConfig = true;
			BlockAboutProfiles = true;
			BlockAboutSupport = true;
			CaptivePortal = false;
			DisableAppUpdate = true;
			DisableFeedbackCommands = true;
			DisableBuiltinPDFViewer = true; # Considered a security liability
			DisableFirefoxStudies = true;
			DisableFirefoxAccounts = true; # Disable Firefox Sync
			DisableFirefoxScreenshots = true; # No screenshots?
			DisableForgetButton = true; # Thing that can wipe history for X time, handled differently
			DisableMasterPasswordCreation = true; # To be determined how to handle master password
			DisableProfileImport = true; # Purity enforcement: Only allow nix-defined profiles
			DisableProfileRefresh = true; # Disable the Refresh Firefox button on about:support and support.mozilla.org
			DisableSetDesktopBackground = true; # Remove the “Set As Desktop Background…” menuitem when right clicking on an image, because Nix is the only thing that can manage the backgroud
			DisableSystemAddonUpdate = true; # Do not allow addon updates
			DisplayMenuBar = "default-off"; # Whether to show the menu bar
			DisablePocket = true;
			DisableTelemetry = true;
			DisableFormHistory = true;
			DisablePasswordReveal = true;
			DontCheckDefaultBrowser = true; # Stop being attention whore
			HardwareAcceleration = false; # Disabled as it's exposes points for fingerprinting
			OfferToSaveLogins = false; # Managed by KeepAss instead
			EnableTrackingProtection = {
				Value = true;
				Locked = true;
				Cryptomining = true;
				Fingerprinting = true;
				EmailTracking = true;
				# Exceptions = ["https://example.com"]
			};
			EncryptedMediaExtensions = {
				Enabled = true;
				Locked = true;
			};
			ExtensionUpdate = false; # Purity Enforcement: Do not update extensions

			FirefoxHome = {
				Search = false;
				TopSites = true;
				SponsoredTopSites = false; # Fuck you
				Highlights = true;
				Pocket = false;
				SponsoredPocket = false; # Fuck you
				Snippets = false;
				Locked = true;
			};
			FirefoxSuggest = {
				WebSuggestions = false;
				SponsoredSuggestions = false; # Fuck you
				ImproveSuggest = false;
				Locked = true;
			};
			NoDefaultBookmarks = true; # Do not set default bookmarks
			PasswordManagerEnabled = false; # Managed by KeepAss
			PDFjs = {
				Enabled = false; # Fuck No, HELL NO
				EnablePermissions = false;
			};
			PictureInPicture = {
				Enabled = true;
				Locked = true;
			};
			PromptForDownloadLocation = true;
			SanitizeOnShutdown = {
				Cache = true;
				Cookies = false;
				Downloads = true;
				FormData = true;
				History = false;
				Sessions = false;
				SiteSettings = false;
				OfflineApps = true;
				Locked = true;
			};
			SearchBar = "separate";
			SearchEngines = {
				PreventInstalls = true;
				Remove = [
					"Amazon.com" # Fuck you
					"Bing" # Fuck you
					"Google" # FUCK YOUU
				];
				Default = "DuckDuckGo";
			};
			SearchSuggestEnabled = false;
			ShowHomeButton = true;

			StartDownloadsInTempDirectory = true; # For speed? May fuck up the system on low ram
			UserMessaging = {
				ExtensionRecommendations = false; # Don’t recommend extensions while the user is visiting web pages
				FeatureRecommendations = false; # Don’t recommend browser features
				Locked = true; # Prevent the user from changing user messaging preferences
				MoreFromMozilla = false; # Don’t show the “More from Mozilla” section in Preferences
				SkipOnboarding = true; # Don’t show onboarding messages on the new tab page
				UrlbarInterventions = false; # Don’t offer suggestions in the URL bar
				WhatsNew = false; # Remove the “What’s New” icon and menuitem
			};
			UseSystemPrintDialog = true;
		};

		profiles.Default = {
			settings = {
			# Enable letterboxing
			"privacy.resistFingerprinting.letterboxing" = true;

			# WebGL
			"webgl.disabled" = true;

			"browser.preferences.defaultPerformanceSettings.enabled" = false;
			"layers.acceleration.disabled" = true;
			"privacy.globalprivacycontrol.enabled" = true;

			"browser.newtabpage.activity-stream.showSponsoredTopSites" = false;

			# "network.trr.mode" = 3;

			# "network.dns.disableIPv6" = false;

			"privacy.donottrackheader.enabled" = true;

			# "privacy.clearOnShutdown.history" = true;
			# "privacy.clearOnShutdown.downloads" = true;
			# "browser.sessionstore.resume_from_crash" = true;

			# See https://librewolf.net/docs/faq/#how-do-i-fully-prevent-autoplay for options
			"media.autoplay.blocking_policy" = 2;

			"privacy.resistFingerprinting" = true;

			"signon.management.page.breach-alerts.enabled" = false; # Disable firefox password checking against a breach database
			};
		};
	};
}

