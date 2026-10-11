# =============================================================================
#  Homebrew Cask boilerplate
#
#  How to use:
#    1. Copy to Casks/<token>.rb. The file name MUST equal the token below.
#    2. Fill in the REQUIRED section.
#    3. Uncomment what you need from the OPTIONAL sections, delete the rest.
#    4. Check it:  brew audit --cask --strict --online <you>/tap/<token>
#                  brew style --fix Casks/<token>.rb
#                  brew install --cask <you>/tap/<token>
#                  brew uninstall --zap --cask <you>/tap/<token>
#
#  Stanzas are listed in the order `brew style` expects. Keep that order and
#  separate the groups with one blank line, as below.
#
#  Docs: https://docs.brew.sh/Cask-Cookbook
# =============================================================================

cask "my-app" do # token: lowercase, words joined with "-", no "app"/"for-mac"

  # ---------------------------------------------------------------------------
  # Local variables (your own). Define them BEFORE first use, at this top
  # level, NOT inside a do…end block (they wouldn't be visible outside it).
  # Use lowercase names. A CONSTANT would leak into Homebrew's namespace.
  # ---------------------------------------------------------------------------
  # bundle_id = "com.example.MyApp"
  # repo      = "example/my-app"

  # ---------------------------------------------------------------------------
  # Architecture / OS switches (only if downloads differ per CPU or OS)
  # ---------------------------------------------------------------------------
  # `arch` gives you #{arch} to use in url, etc.
  # arch arm: "arm64", intel: "x86_64"
  #
  # Your own per-arch variable:
  # suffix = on_arch_conditional arm: "apple-silicon", intel: "intel"
  #
  # `os` gives you #{os} (only for casks that also support Linux):
  # os macos: "darwin", linux: "linux"

  # ===========================================================================
  # REQUIRED
  # ===========================================================================

  # Upstream version. Use "1.2.3,456" (comma) if you also need a build number:
  # then use version.csv.first / version.csv.second in the url.
  # Other helpers: version.major, version.minor, version.patch,
  #                version.major_minor, version.no_dots, version.dots_to_underscores
  # Use `version :latest` together with `sha256 :no_check` for an unversioned URL.
  version "1.0.0"

  # shasum -a 256 <download>
  sha256 "0000000000000000000000000000000000000000000000000000000000000000"
  #
  # Different checksums per architecture (used with `arch` above):
  # sha256 arm:   "aaaa…",
  #        intel: "bbbb…"

  # ---------------------------------------------------------------------------
  # Blocks that only apply on some systems. Anything can go inside:
  # version/sha256/url, depends_on, app, binary, zap, …
  # ---------------------------------------------------------------------------
  # on_arm do
  #   …
  # end
  # on_intel do
  #   …
  # end
  # on_sonoma :or_older do   # also :or_newer. Names: on_sequoia, on_tahoe, …
  #   …
  # end
  # on_macos do
  #   …
  # end
  # on_linux do
  #   …
  # end

  # Localized downloads. The first `default: true` block is the fallback.
  # language "de" do
  #   sha256 "…"
  #   "de"                     # returned value → available as #{language}
  # end
  # language "en", default: true do
  #   sha256 "…"
  #   "en-US"
  # end

  # Download URL. #{version}, #{arch}, #{language} and your variables work here.
  url "https://example.com/downloads/MyApp-#{version}.zip"
  #
  # Extra url options (any combination):
  # url "https://cdn.example.com/MyApp-#{version}.dmg",
  #     verified:   "cdn.example.com/",           # needed if url host ≠ homepage host
  #     user_agent: :browser,                     # or :fake, or a custom string
  #     referer:    "https://example.com/download",
  #     cookies:    { "accept_eula" => "1" },
  #     header:     "Authorization: Bearer …",
  #     using:      :post,                        # or :curl, :git, :homebrew_curl, …
  #     data:       { "file" => "MyApp.dmg" }     # POST body (with using: :post)

  name "My App"                                   # official name; can repeat for aliases
  # name "MyApp Pro"
  desc "Short description, no app name, no trailing period, <80 chars"
  homepage "https://example.com/"

  # ===========================================================================
  # OPTIONAL: update checking  (`brew livecheck --cask <token>`)
  # ===========================================================================
  # GitHub releases:
  # livecheck do
  #   url :url
  #   strategy :github_latest
  # end
  #
  # Version number found on a web page:
  # livecheck do
  #   url :homepage                 # or :url, or any "https://…" string
  #   regex(/Version\s+v?(\d+(?:\.\d+)+)/i)
  # end
  #
  # Sparkle appcast (many Mac apps):
  # livecheck do
  #   url "https://example.com/appcast.xml"
  #   strategy :sparkle, &:short_version   # or &:version, or a block
  # end
  #
  # Follow a redirect and read the version from the final file name:
  # livecheck do
  #   url :url
  #   strategy :header_match
  # end
  #
  # Turn it off:
  # livecheck do
  #   skip "No version information available"
  # end

  # ===========================================================================
  # OPTIONAL: lifecycle
  # ===========================================================================
  # deprecate! date: "2026-12-31", because: :unmaintained   # or :discontinued, :unsigned, "custom text"
  # disable!   date: "2027-06-30", because: :discontinued
  # Optional extra key for either: replacement_cask: "other-app"  (or replacement_formula:)

  # ===========================================================================
  # OPTIONAL: requirements & metadata
  # ===========================================================================

  # The app updates itself (Sparkle etc.); `brew upgrade` will skip it
  # unless run with --greedy.
  # auto_updates true

  # conflicts_with cask: "my-app@beta"
  # conflicts_with cask: ["my-app@beta", "my-app@nightly"]

  # macOS versions. Symbols: :big_sur, :monterey, :ventura, :sonoma, :sequoia, :tahoe, …
  # depends_on macos: ">= :sonoma"       # minimum
  # depends_on macos: :tahoe             # EXACTLY this version (rarely wanted)
  # depends_on maximum_macos: :sequoia   # maximum
  # depends_on :macos                    # macOS only, any version
  #
  # depends_on arch: :arm64              # or :x86_64
  # depends_on formula: "ffmpeg"         # or an array
  # depends_on cask: "other-app"         # or an array

  # Download format, if Homebrew can't guess it from the extension:
  # container type: :zip             # :dmg, :tar, :seven_zip, :rar, :naked, …
  # container nested: "MyApp-#{version}/MyApp.dmg"   # archive inside the archive

  # Rename files after unpacking, before installing (glob allowed in "from"):
  # rename "MyApp*.pkg", "MyApp.pkg"

  # ===========================================================================
  # ARTIFACTS: what gets installed. You need at least one.
  # Paths are relative to the unpacked download.
  # ===========================================================================

  app "My App.app"
  # app "My App.app", target: "Other Name.app"          # install under another name
  # app "Folder/My App.app", target: "#{appdir}/Sub/My App.app"

  # suite "My Suite"                     # a whole folder of apps → /Applications/My Suite
  # app_image "MyApp.AppImage"           # Linux AppImage

  # Installer packages. Prefer `app` when the download has a plain .app.
  # pkg "MyApp.pkg"
  # pkg "MyApp.pkg", choices: [
  #   {
  #     "choiceIdentifier" => "com.example.optional",
  #     "choiceAttribute"  => "selected",
  #     "attributeSetting" => 0,
  #   },
  # ]
  # installer manual: "Install My App.app"        # user has to click through it
  # installer script: {
  #   executable: "Install.sh",
  #   args:       ["--silent"],
  #   sudo:       true,
  # }

  # Command-line tools → symlinked into $(brew --prefix)/bin
  # binary "#{appdir}/My App.app/Contents/MacOS/mycli"
  # binary "#{appdir}/My App.app/Contents/MacOS/mycli", target: "my-cli"
  #
  # Generate a tiny wrapper script instead of a symlink:
  # command_wrapper "my-cli", executable: "#{appdir}/My App.app/Contents/MacOS/My App",
  #                           args:       ["--cli"],
  #                           env:        { "MYAPP_HOME" => "~/.myapp" }
  #
  # Write a script file into the staged download (e.g. for `binary` to link):
  # generated_script "my-cli.sh", content: <<~SH
  #   #!/bin/sh
  #   exec "#{appdir}/My App.app/Contents/MacOS/My App" "$@"
  # SH

  # manpage "docs/my-cli.1"
  # bash_completion "completions/my-cli.bash"
  # zsh_completion  "completions/_my-cli"
  # fish_completion "completions/my-cli.fish"
  # pwsh_completion "completions/my-cli.ps1"
  # generate_completions_from_executable "#{appdir}/My App.app/Contents/MacOS/mycli", "completion",
  #                                      shells: [:bash, :zsh, :fish]

  # Other macOS artifact types (install to the matching ~/Library folder):
  # colorpicker      "MyPicker.colorPicker"
  # dictionary       "MyDict.dictionary"
  # font             "MyFont.otf"
  # input_method     "MyInput.app"
  # internet_plugin  "MyPlugin.plugin"
  # keyboard_layout  "MyLayout.bundle"
  # prefpane         "MyPane.prefPane"
  # qlplugin         "MyPreview.qlgenerator"
  # mdimporter       "MyImporter.mdimporter"
  # screen_saver     "MySaver.saver"
  # service          "MyService.workflow"
  # audio_unit_plugin "MyAU.component"
  # vst_plugin       "MyPlugin.vst"
  # vst3_plugin      "MyPlugin.vst3"

  # Copy/move anything anywhere (target must be absolute):
  # artifact "Extras/config.json", target: "#{Dir.home}/.myapp/config.json"

  # Only unpack, install nothing (cannot be combined with other artifacts):
  # stage_only true

  # ===========================================================================
  # OPTIONAL: hooks (run before/after install/uninstall)
  #
  # Current Homebrew uses declarative *_steps. The old Ruby blocks
  # `preflight do`, `postflight do`, `uninstall_preflight do` and
  # `uninstall_postflight do` are deprecated.
  # Paths are relative to the unpacked download unless you pass `base:`
  # (e.g. base: :home, base: :appdir, base: :staged_path).
  # ===========================================================================
  # preflight_steps do
  #   mkdir_p "Prepared"
  # end
  #
  # postflight_steps do
  #   set_permissions "#{appdir}/My App.app/Contents/MacOS/helper", "0755"
  #   symlink "Prepared/thing", "ThingLink"
  #   write_file "Library/Application Support/MyApp/settings.json", '{"telemetry":false}', base: :home
  #   inreplace "config.ini", "telemetry=1", "telemetry=0"
  #   run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "#{appdir}/My App.app"]
  #
  #   if_path_exists "legacy.cfg" do
  #     remove "legacy.cfg"
  #   end
  # end
  #
  # uninstall_preflight_steps do
  #   run "#{appdir}/My App.app/Contents/MacOS/mycli", args: ["--unregister"], must_succeed: false
  # end
  #
  # uninstall_postflight_steps do
  #   remove "Library/Application Support/MyApp/cache", base: :home, recursive: true
  # end
  #
  # Other step actions: mkdir, touch, move/mv, move_contents, copy, remove,
  # ln_s, ln_sf, write, change_dylib_id, delete_keychain_certificate,
  # set_ownership, unless_path_exists, on_macos/on_linux.

  # ===========================================================================
  # OPTIONAL: uninstall  (`brew uninstall`). Mostly needed for `pkg` installs.
  # Directives run in this order no matter how you write them.
  # ===========================================================================
  # uninstall early_script: {
  #             executable: "#{appdir}/My App.app/Contents/Resources/uninstall.sh",
  #             sudo:       true,
  #           },
  #           launchctl:    "com.example.MyApp.helper",      # launch agents/daemons
  #           quit:         "com.example.MyApp",             # quit running app (bundle ID)
  #           signal:       ["TERM", "com.example.MyApp"],
  #           login_item:   "My App",
  #           kext:         "com.example.driver",
  #           script:       {
  #             executable: "/usr/local/bin/myapp-uninstall",
  #             args:       ["--force"],
  #             sudo:       true,
  #           },
  #           pkgutil:      "com.example.pkg.*",             # pkgutil --pkgs | grep example
  #           delete:       "/usr/local/bin/mycli",          # removes immediately
  #           trash:        "/Library/MyApp",                # moves to Trash
  #           rmdir:        "/Library/Application Support/MyApp",  # only if empty
  #           on_upgrade:   :quit                            # also do `quit` on `brew upgrade`

  # ===========================================================================
  # OPTIONAL: zap  (`brew uninstall --zap`) removes user data and settings.
  # Same directives as `uninstall`. Usually just `trash`.
  #
  # Find leftovers:
  #   mdls -name kMDItemCFBundleIdentifier -r "/Applications/My App.app"
  #   find ~/Library /Library /private/var/folders -iname "*myapp*" 2>/dev/null
  # Keep the list sorted alphabetically (brew style checks it).
  # ===========================================================================
  # zap trash: [
  #   "~/Library/Application Scripts/#{bundle_id}",
  #   "~/Library/Application Support/My App",
  #   "~/Library/Caches/#{bundle_id}",
  #   "~/Library/Containers/#{bundle_id}",
  #   "~/Library/Group Containers/*.#{bundle_id}",
  #   "~/Library/HTTPStorages/#{bundle_id}",
  #   "~/Library/HTTPStorages/#{bundle_id}.binarycookies",
  #   "~/Library/Logs/My App",
  #   "~/Library/Preferences/#{bundle_id}.plist",
  #   "~/Library/Saved Application State/#{bundle_id}.savedState",
  #   "~/Library/WebKit/#{bundle_id}",
  # ],
  #     rmdir: "~/Library/Application Support/Example Inc"

  # ===========================================================================
  # OPTIONAL: caveats  (message shown after install). #{token}, #{appdir} work.
  # ===========================================================================
  # Free text:
  # caveats <<~EOS
  #   #{token} is not notarized by Apple. On first launch macOS will block it:
  #   open it once, then go to System Settings → Privacy & Security and click
  #   "Open Anyway". This is only needed once.
  # EOS
  #
  # Or built-in messages (one or more):
  # caveats do
  #   unsigned_accessibility                # "grant Accessibility in System Settings"
  #   requires_rosetta                      # Intel-only app on Apple Silicon
  #   reboot                                # or: logout
  #   path_environment_variable "/opt/myapp/bin"
  #   license "https://example.com/eula"    # or: free_license "…"
  #   depends_on_java "21"
  #   files_in_usr_local
  #   kext
  # end
end
