
{
  config,
  lib,
  pkgs,
  ...
}:

{
  home.file."/home/safri/.config/vesktop/themes/tokyo-night.theme.css".text = ''
    /**
     * @name Tokyo Night
     * @description Discord Port of Visual Studio Code Theme
     * @author Ashtrath
     * @version 2.0.2
     * @authorId 2354831939099688962
     */

    /* DONT TOUCH THIS!!! */
    @import url("https://dyzean.github.io/Tokyo-Night/main.css");

    /*  Read this before editing stuff!!!
    *
    *   > To comment or uncomment a line you need to put those "/" and "*" characters as you can see at the beginning and ending of my comments.
    *      (You don't need to put a * at each line like I do, it's just for readability). See more here : https://developer.mozilla.org/en-US/docs/Web/CSS/Comments
    *
    *   > You can play with the values and see how it goes, don't delete "px" after the value if you don't have knowledges in CSS.
    *
    *   > To change the colors, replace the HEX code with the one you picked here : https://htmlcolorcodes.com
    */

    /* ====== Optional Addons ====== */
    @import url("https://dyzean.github.io/Tokyo-Night/addons/revert-rebrand.css");
    @import url("https://nyri4.github.io/Discolored/main.css");

    /* VSCode User Area, get Visual Studio like user area (Enabled by default)
      note: this addons doesn't works well with Compact Mode addon,
      please disable this when using Compact Mode addon */
    @import url("https://dyzean.github.io/Tokyo-Night/addons/vscode-user-area.css");

    /* Syntax Highlight, get hljs styling with Tokyo Night scheme (Enabled by default) */
    @import url("https://dyzean.github.io/Tokyo-Night/addons/syntax-highlight.css");

    /* Username Background, get colorful background behind username on chat, works best with Monospace addon. (Disabled by default) */
    /* @import url("https://dyzean.github.io/Tokyo-Night/addons/username-background.css"); */

    /* Mac Like Titlebar (windows only), get mac style titlebar on windows client (Enabled by default) */
    @import url("https://dyzean.github.io/Tokyo-Night/addons/mac-titlebar.css");

    /* Compact Mode, hide some UI part on specific windows size,
      <920px Channel sidebar and member list get hidden, <600px Chat window only. (Disabled by default) */
    /* @import url("https://dyzean.github.io/Tokyo-Night/addons/compact-mode.css"); */

    /* Monospace, use monospaced font (JetBrains Mono) instead the default one (Disabled by default) */
    /* @import url("https://dyzean.github.io/Tokyo-Night/addons/monospace-fonts.css"); */

    /* Square Avatar, get square avatar on chat memberlist and user area (Disabled by default) */
    /* @import url("https://dyzean.github.io/Tokyo-Night/addons/square-avatar.css"); */


    /* ==== Discord Variables ==== */
    .theme-dark { /* Dark Mode */

      /*  Header Color  */
      --header-primary: var(--text-normal);
      --header-secondary: var(--text-muted);

      /*  Text Color  */
      --text-normal: #b1bae6;
      --text-muted: #565f89;
      --interactive-normal: #5f647e;
      --interactive-hover: #a2a6c2;
      --interactive-active: #b5bad1;
      --interactive-muted: #55576b;

      /* Background Color */
      --background-primary: #1a1b26;
      --background-secondary: #171722;
      --background-secondary-alt: #13131a;
      --background-tertiary: #16161e;
      --background-tertiary-alt: var(--background-secondary-alt);
      --background-accent: #434461;
      --background-floating: #161620;
      --background-modifier-hover: #212331c0;
      --background-modifier-active: #282a3680;
      --background-modifier-selected: #24263171;
      --background-modifier-accent: #1e1e29;
      --background-mentioned: #252836;
      --border-mentioned: #474c64;
      --background-mentioned-hover: #2f3344;
      --accent-color: #7aa2f7;

      /* Folder Color */
      --folder-color: #202332d0;
      --folder-color-light: #2f3342d0;

      /* Scrollbars Color */
      --scrollbar-thin-thumb: transparent;
      --scrollbar-thin-track: transparent;
      --scrollbar-auto-thumb: #2b2b46af;
      --scrollbar-auto-thumb-hover: #27273d85;
      --scrollba-auto-track: transparent;
      --scrollbar-auto-scrollbar-color-thumb: var(--scrollbar-auto-thumb);
      --scrollbar-auto-scrollbar-color-track: var(--scrollbar-auto-track);

      /* Chat Box Color */
      --channeltextarea-background: var(--background-secondary);
      --channeltextarea-background-hover: var(--background-tertiary);

    	/* Square avatar addons */
    	--avatar-roundess: 5px;

      /* Mac Titlebar addons */
      --close-button-color: #e92a2ade;
      --maximize-button-color: #f7bc1bde;
      --minimize-button-color: #12db33de;
    }

    .theme-light { /* Light Mode */

      /*  Header Color  */
      --header-primary: var(--text-normal);
      --header-secondary: var(--text-muted);

      /* Text Color */
      --text-normal: #2e3338;
      --text-muted: #747f8d;
      --interactive-normal: #4c505e;
      --interactive-hover: #404350;
      --interactive-active: #373a44;
      --interactive-muted: #77797c;

      /* Background Color */
      --background-primary: #d5d6db;
      --background-secondary: #cecfd4;
      --background-secondary-alt: #b6b7bd;
      --background-tertiary: #c5c6cc;
      --background-tertiary-alt: #bbbbc2;
      --background-accent: #9ca3bb;
      --background-floating: #c2c2c9;
      --background-mentioned: #c4c7da;
      --background-modifier-hover: #2c2a2a25;
      --background-modifier-active: #5a525229;
      --background-modifier-selected: #555e693d;
      --background-modifier-accent: #06060714;
      --border-mentioned: #a9afcf;
      --background-mentioned-hover: #cfd2e9;
      --accent-color: #365aaa;

      /* Folder Color */
      --folder-color: #a7a6a6d0;
      --folder-color-light: #afafafd0;

      /* Input Box Color */
      --input-box-bg: #c2c2c7;
      --input-box-border: #b3b4b8;
      --input-box-border-focus: #959699;

      /* Scrollbars Color */
      --scrollbar-thin-thumb: transparent;
      --scrollbar-thin-track: transparent;
      --scrollbar-auto-thumb: #a0a0a0af;
      --scrollbar-auto-thumb-hover: #77777785;
      --scrollbar-auto-track: transparent;
      --scrollbar-auto-scrollbar-color-thumb: var(--scrollbar-auto-thumb);
      --scrollbar-auto-scrollbar-color-track: var(--scrollbar-auto-track);

      /* Chat Box Color */
      --channeltextarea-background: var(--background-secondary);
      --channeltextarea-background-hover: var(--background-tertiary);

      /* Square avatar addons */
    	--avatar-roundess: 5px;

      /* Mac Titlebar addons */
      --close-button-color: #e92a2ade;
      --maximize-button-color: #f7bc1bde;
      --minimize-button-color: #12db33de;
      --button-position: row;

    }

  '';

  home.file."/home/safri/.config/vesktop/settings/settings.json".text = ''
    {
        "autoUpdate": true,
        "autoUpdateNotification": true,
        "useQuickCss": true,
        "themeLinks": [],
        "enabledThemes": [
            "tokyo-night.theme.css"
        ],
        "enableReactDevtools": false,
        "frameless": false,
        "transparent": false,
        "winCtrlQ": false,
        "disableMinSize": false,
        "winNativeTitleBar": false,
        "plugins": {
            "ChatInputButtonAPI": {
                "enabled": false
            },
            "CommandsAPI": {
                "enabled": true
            },
            "MemberListDecoratorsAPI": {
                "enabled": false
            },
            "MessageAccessoriesAPI": {
                "enabled": true
            },
            "MessageDecorationsAPI": {
                "enabled": false
            },
            "MessageEventsAPI": {
                "enabled": true
            },
            "MessagePopoverAPI": {
                "enabled": false
            },
            "MessageUpdaterAPI": {
                "enabled": false
            },
            "ServerListAPI": {
                "enabled": false
            },
            "UserSettingsAPI": {
                "enabled": true
            },
            "AccountPanelServerProfile": {
                "enabled": false
            },
            "AlwaysAnimate": {
                "enabled": true
            },
            "AlwaysExpandRoles": {
                "enabled": false
            },
            "AlwaysTrust": {
                "enabled": true
            },
            "AnonymiseFileNames": {
                "enabled": false
            },
            "AppleMusicRichPresence": {
                "enabled": false
            },
            "WebRichPresence (arRPC)": {
                "enabled": false
            },
            "BANger": {
                "enabled": false
            },
            "BetterFolders": {
                "enabled": true
            },
            "BetterGifAltText": {
                "enabled": false
            },
            "BetterGifPicker": {
                "enabled": false
            },
            "BetterNotesBox": {
                "enabled": false
            },
            "BetterRoleContext": {
                "enabled": false
            },
            "BetterRoleDot": {
                "enabled": true
            },
            "BetterSessions": {
                "enabled": false
            },
            "BetterSettings": {
                "enabled": true
            },
            "BetterUploadButton": {
                "enabled": false
            },
            "BiggerStreamPreview": {
                "enabled": false
            },
            "BlurNSFW": {
                "enabled": true
            },
            "CallTimer": {
                "enabled": true
            },
            "ClearURLs": {
                "enabled": true
            },
            "ClientTheme": {
                "enabled": false
            },
            "ColorSighted": {
                "enabled": false
            },
            "ConsoleJanitor": {
                "enabled": false
            },
            "ConsoleShortcuts": {
                "enabled": false
            },
            "CopyEmojiMarkdown": {
                "enabled": false
            },
            "CopyFileContents": {
                "enabled": false
            },
            "CopyUserURLs": {
                "enabled": false
            },
            "CrashHandler": {
                "enabled": true
            },
            "CtrlEnterSend": {
                "enabled": false
            },
            "CustomRPC": {
                "enabled": false
            },
            "CustomIdle": {
                "enabled": false
            },
            "Dearrow": {
                "enabled": true
            },
            "Decor": {
                "enabled": false
            },
            "DisableCallIdle": {
                "enabled": false
            },
            "DontRoundMyTimestamps": {
                "enabled": false
            },
            "EmoteCloner": {
                "enabled": false
            },
            "Experiments": {
                "enabled": false
            },
            "F8Break": {
                "enabled": false
            },
            "FakeNitro": {
                "enabled": true
            },
            "FakeProfileThemes": {
                "enabled": false
            },
            "FavoriteEmojiFirst": {
                "enabled": false
            },
            "FavoriteGifSearch": {
                "enabled": false
            },
            "FixCodeblockGap": {
                "enabled": false
            },
            "FixSpotifyEmbeds": {
                "enabled": true
            },
            "FixYoutubeEmbeds": {
                "enabled": false
            },
            "ForceOwnerCrown": {
                "enabled": false
            },
            "FriendInvites": {
                "enabled": false
            },
            "FriendsSince": {
                "enabled": false
            },
            "GameActivityToggle": {
                "enabled": false
            },
            "GifPaste": {
                "enabled": false
            },
            "GreetStickerPicker": {
                "enabled": false
            },
            "HideAttachments": {
                "enabled": false
            },
            "iLoveSpam": {
                "enabled": false
            },
            "IgnoreActivities": {
                "enabled": false
            },
            "ImageLink": {
                "enabled": false
            },
            "ImageZoom": {
                "enabled": false
            },
            "ImplicitRelationships": {
                "enabled": false
            },
            "InvisibleChat": {
                "enabled": false
            },
            "KeepCurrentChannel": {
                "enabled": false
            },
            "LastFMRichPresence": {
                "enabled": false
            },
            "LoadingQuotes": {
                "enabled": false
            },
            "MemberCount": {
                "enabled": false
            },
            "MentionAvatars": {
                "enabled": false
            },
            "MessageClickActions": {
                "enabled": false
            },
            "MessageLatency": {
                "enabled": false
            },
            "MessageLinkEmbeds": {
                "enabled": false
            },
            "MessageLogger": {
                "enabled": false
            },
            "MessageTags": {
                "enabled": false
            },
            "MoreCommands": {
                "enabled": false
            },
            "MoreKaomoji": {
                "enabled": false
            },
            "MoreUserTags": {
                "enabled": false
            },
            "Moyai": {
                "enabled": false
            },
            "MutualGroupDMs": {
                "enabled": false
            },
            "NewGuildSettings": {
                "enabled": false
            },
            "NoBlockedMessages": {
                "enabled": false
            },
            "NoDefaultHangStatus": {
                "enabled": false
            },
            "NoDevtoolsWarning": {
                "enabled": false
            },
            "NoF1": {
                "enabled": false
            },
            "NoMaskedUrlPaste": {
                "enabled": false
            },
            "NoMosaic": {
                "enabled": false
            },
            "NoOnboardingDelay": {
                "enabled": false
            },
            "NoPendingCount": {
                "enabled": false
            },
            "NoProfileThemes": {
                "enabled": false
            },
            "NoReplyMention": {
                "enabled": false
            },
            "NoScreensharePreview": {
                "enabled": false
            },
            "NoServerEmojis": {
                "enabled": false
            },
            "NoTypingAnimation": {
                "enabled": false
            },
            "NoUnblockToJump": {
                "enabled": false
            },
            "NormalizeMessageLinks": {
                "enabled": false
            },
            "NotificationVolume": {
                "enabled": false
            },
            "NSFWGateBypass": {
                "enabled": false
            },
            "OnePingPerDM": {
                "enabled": false
            },
            "oneko": {
                "enabled": false
            },
            "OpenInApp": {
                "enabled": false
            },
            "OverrideForumDefaults": {
                "enabled": false
            },
            "PartyMode": {
                "enabled": false
            },
            "PauseInvitesForever": {
                "enabled": false
            },
            "PermissionFreeWill": {
                "enabled": false
            },
            "PermissionsViewer": {
                "enabled": false
            },
            "petpet": {
                "enabled": false
            },
            "PictureInPicture": {
                "enabled": false
            },
            "PinDMs": {
                "enabled": false
            },
            "PlainFolderIcon": {
                "enabled": false
            },
            "PlatformIndicators": {
                "enabled": false
            },
            "PreviewMessage": {
                "enabled": false
            },
            "PronounDB": {
                "enabled": false
            },
            "QuickMention": {
                "enabled": false
            },
            "QuickReply": {
                "enabled": false
            },
            "ReactErrorDecoder": {
                "enabled": false
            },
            "ReadAllNotificationsButton": {
                "enabled": false
            },
            "RelationshipNotifier": {
                "enabled": false
            },
            "ReplaceGoogleSearch": {
                "enabled": false
            },
            "ReplyTimestamp": {
                "enabled": false
            },
            "RevealAllSpoilers": {
                "enabled": false
            },
            "ReverseImageSearch": {
                "enabled": false
            },
            "ReviewDB": {
                "enabled": false
            },
            "RoleColorEverywhere": {
                "enabled": false
            },
            "SearchReply": {
                "enabled": false
            },
            "SecretRingToneEnabler": {
                "enabled": false
            },
            "Summaries": {
                "enabled": false
            },
            "SendTimestamps": {
                "enabled": false
            },
            "ServerInfo": {
                "enabled": false
            },
            "ServerListIndicators": {
                "enabled": false
            },
            "ShikiCodeblocks": {
                "enabled": false
            },
            "ShowAllMessageButtons": {
                "enabled": false
            },
            "ShowConnections": {
                "enabled": false
            },
            "ShowHiddenChannels": {
                "enabled": false
            },
            "ShowHiddenThings": {
                "enabled": false
            },
            "ShowMeYourName": {
                "enabled": false
            },
            "ShowTimeoutDuration": {
                "enabled": false
            },
            "SilentMessageToggle": {
                "enabled": false
            },
            "SilentTyping": {
                "enabled": false
            },
            "SortFriendRequests": {
                "enabled": false
            },
            "SpotifyControls": {
                "enabled": false
            },
            "SpotifyCrack": {
                "enabled": false
            },
            "SpotifyShareCommands": {
                "enabled": false
            },
            "StartupTimings": {
                "enabled": false
            },
            "StickerPaste": {
                "enabled": false
            },
            "StreamerModeOnStream": {
                "enabled": false
            },
            "SuperReactionTweaks": {
                "enabled": false
            },
            "TextReplace": {
                "enabled": false
            },
            "ThemeAttributes": {
                "enabled": false
            },
            "TimeBarAllActivities": {
                "enabled": false
            },
            "Translate": {
                "enabled": false
            },
            "TypingIndicator": {
                "enabled": false
            },
            "TypingTweaks": {
                "enabled": false
            },
            "Unindent": {
                "enabled": false
            },
            "UnlockedAvatarZoom": {
                "enabled": false
            },
            "UnsuppressEmbeds": {
                "enabled": false
            },
            "UserVoiceShow": {
                "enabled": false
            },
            "USRBG": {
                "enabled": false
            },
            "ValidReply": {
                "enabled": false
            },
            "ValidUser": {
                "enabled": false
            },
            "VoiceChatDoubleClick": {
                "enabled": false
            },
            "VcNarrator": {
                "enabled": false
            },
            "VencordToolbox": {
                "enabled": false
            },
            "ViewIcons": {
                "enabled": false
            },
            "ViewRaw": {
                "enabled": false
            },
            "VoiceDownload": {
                "enabled": false
            },
            "VoiceMessages": {
                "enabled": false
            },
            "VolumeBooster": {
                "enabled": true
            },
            "WebKeybinds": {
                "enabled": true
            },
            "WebScreenShareFixes": {
                "enabled": true
            },
            "WhoReacted": {
                "enabled": false
            },
            "XSOverlay": {
                "enabled": false
            },
            "YoutubeAdblock": {
                "enabled": true
            },
            "NoTrack": {
                "enabled": true,
                "disableAnalytics": true
            },
            "WebContextMenus": {
                "enabled": true,
                "addBack": true
            },
            "Settings": {
                "enabled": true,
                "settingsLocation": "aboveNitro"
            },
            "SupportHelper": {
                "enabled": true
            }
        },
        "notifications": {
            "timeout": 5000,
            "position": "bottom-right",
            "useNative": "not-focused",
            "logLimit": 50
        },
        "cloud": {
            "authenticated": false,
            "url": "https://api.vencord.dev/",
            "settingsSync": false,
            "settingsSyncVersion": 1726407487610
        }
    }
  '';
}
