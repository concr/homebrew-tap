cask "kaset" do
  version "0.14.2"
  sha256 "535e95f2ef3b9a8100753af94fce6acbf6f8791e3eadcae8530440a1e34232fd"

  url "https://github.com/sozercan/kaset/releases/download/v0.14.2/kaset-v#{version}.dmg"
  name "Kaset"
  desc "Missing YouTube and YouTube Music app"
  homepage "https://sozercan.github.io/kaset/"

  livecheck do
    url :url
    strategy :github_latest
  end

  # auto_updates true

  depends_on arch: [:arm64, :intel]
  depends_on macos: :sequoia

  # conflicts_with cask: ""

  app "Kaset.app"

  bundle_id = "com.sertacozercan.Kaset"

  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Kaset.app"]
    run "/bin/echo", args: ["🦠 Removed quarantine from {{token}}."], print_stdout: true
  end

  zap trash: [
    "~/Library/Application Support/#{bundle_id}",
    "~/Library/Caches/#{bundle_id}",
    "~/Library/HTTPStorages/#{bundle_id}",
    "~/Library/Preferences/#{bundle_id}.plist",
    "~/Library/Saved Application State/#{bundle_id}.savedState",
  ]

  # caveats <<~EOS
  #   #{token} is not notarized by Apple. On first launch macOS will block it:
  #   open it once, then go to System Settings → Privacy & Security and click
  #   "Open Anyway". This is only needed once.
  #
  #   Run the commmand m5uploader from terminal and then notarize it in settings.
  # EOS

  # caveats do
  #   unsigned_accessibility
  # end
end
