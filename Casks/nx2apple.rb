cask "nx2apple" do

  version "0.7.5"
  sha256 "9ff78481996665b2d375adcf41a4445c64dae71a8f535f803d91fa24b31d5d51"

  url "https://github.com/LNPANDY/NX2Apple/releases/download/v#{version}/NS-Port-Builder-macOS-arm64.zip"
  name "NX2Apple"
  desc "Play your own Switch games on iPhone/iPad — one-click macOS app, no terminal."
  homepage "https://github.com/LNPANDY/NX2Apple"

  livecheck do
    url :url
    strategy :github_latest
  end

  # auto_updates true

  depends_on arch: :arm64
  depends_on macos: :ventura
  conflicts_with cask: "nx2apple@rc"

  app "NS Port Builder.app"
  bundle_id = "org.nxnative.NSPortBuilder"

  zap trash: [
    "~/Library/Application Support/#{bundle_id}",
    "~/Library/Caches/#{bundle_id}",
    "~/Library/HTTPStorages/#{bundle_id}",
    "~/Library/Preferences/#{bundle_id}.plist",
    "~/Library/Saved Application State/#{bundle_id}.savedState",
  ]

  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/m5uploader.app"]
    run "/bin/echo", args: ["🦠 Removed quarantine from {{token}}."], print_stdout: true
  end

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
