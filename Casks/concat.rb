cask "concat" do

  arch arm: "arm64", intel: "x86_64"
  version "0.2.9"

  # curl -sL https://github.com/jub0t/Concat/releases/download/v0.2.9/Concat-0.2.9-macos-arm64.dmg | sha256sum
  # curl -sL https://github.com/jub0t/Concat/releases/download/v0.2.9/Concat-0.2.9-macos-x86_64.dmg | sha256sum
  sha256
    arm:   "7fdeb727155043dfb35018ff49819230426f0ea65375ea4062c41ec59682ed0e",
    intel: "5378994af52d4319a4098bfd6cfad90033133e38c6ca33f9cd83f0ca9f2df0ea"

  url "https://github.com/jub0t/Concat/releases/download/v#{version}/Concat-#{version}-macos-#{arch}.dmg"
  name "Concat"
  desc "The truly free, open-source, local-first, cross-platform CapCut replacement. Scriptable through a JSON-RPC API & MCP."
  homepage "https://github.com/jub0t/Concat"

  livecheck do
    url :url
    strategy :github_latest
  end

  # auto_updates true

  depends_on arch: [ :arm64, :intel ]
  depends_on macos: :ventura  # runs from 12.0 monterey but 13.0 ventura is the lowest we can use
  # conflicts_with cask: ""

  app "Concat.app"
  bundle_id = "com.concat.editor"

  zap trash: [
    "~/Library/Application Support/#{bundle_id}",
    "~/Library/Caches/#{bundle_id}",
    "~/Library/HTTPStorages/#{bundle_id}",
    "~/Library/Preferences/#{bundle_id}.plist",
    "~/Library/Saved Application State/#{bundle_id}.savedState",
  ]

  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Concat.app"]
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
