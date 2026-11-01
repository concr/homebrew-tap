cask "concut" do

  arch arm: "arm64", intel: "x86_64"
  version "0.2.8"

  # curl -sL https://github.com/jub0t/Concat/releases/download/v0.2.8/Concat-0.2.8-macos-arm64.dmg | sha256sum
  # curl -sL https://github.com/jub0t/Concat/releases/download/v0.2.8/Concat-0.2.8-macos-x86_64.dmg | sha256sum
  sha256 arm:  "4fe1820f36235efe8a28379a224239032c260bef1ad0fb950274c2f832e91805"
  sha25 intel: "c040bd5c14b6de6443dd9c4e00070e57beafcf7cd6347dfc19b8559843bc16e6"

  url "https://github.com/jub0t/Concat/releases/download/v#{version}/Concat-#{version}-macos-#{arch}.dmg"
  name "Concat"
  desc "The truly free, open-source, local-first, cross-platform CapCut replacement. Scriptable through a JSON-RPC API & MCP."
  homepage "https://github.com/jub0t/Concat"

  livecheck do
    url :url
    strategy :github_latest
  end

  # auto_updates true

  depends_on macos: :ventura  # runs from 12.0 monterey but 13.0 ventura is the lowest we can use
  # conflicts_with cask: ""

  app "Concut.app"
  bundle_id = "com.concut.editor"

  zap trash: [
    "~/Library/Application Support/#{bundle_id}",
    "~/Library/Caches/#{bundle_id}",
    "~/Library/HTTPStorages/#{bundle_id}",
    "~/Library/Preferences/#{bundle_id}.plist",
    "~/Library/Saved Application State/#{bundle_id}.savedState",
  ]

  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Concut.app"]
  end

  #caveats <<~EOS
  #  #{token} is not notarized by Apple. On first launch macOS will block it:
  #  open it once, then go to System Settings → Privacy & Security and click
  #  "Open Anyway". This is only needed once.
  #EOS

  # caveats do
  #   unsigned_accessibility 
  # end

end
