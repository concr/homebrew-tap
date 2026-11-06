cask "nx2apple" do
  version "1.2.3"
  sha256 "e91a38b6f72b542f407a9b7ac98faa818a3573eb3d245058aef52c5831ea0162"

  url "https://github.com/LNPANDY/NX2Apple/releases/download/v#{version}/NS-Port-Builder-macOS-arm64.zip"
  name "NX2Apple"
  desc "Play your own Switch games on iPhone/iPad — one-click app, no terminal"
  homepage "https://github.com/LNPANDY/NX2Apple"

  livecheck do
    url :url
    strategy :github_latest
  end

  # auto_updates true

  depends_on arch: [:arm64]
  depends_on macos: :ventura

  app "NS Port Builder.app"

  bundle_id = "org.nxnative.NSPortBuilder"

  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/NS Port Builder.app"]
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
