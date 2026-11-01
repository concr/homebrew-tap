cask "concut" do

  version "0.2.8"
  sha256 "4fe1820f36235efe8a28379a224239032c260bef1ad0fb950274c2f832e91805"

  url "https://github.com/jub0t/Concat/releases/download/v#{version}/Concat-#{version}-macos-arm64.dmg"
  name "Concat"
  desc "The truly free, open-source, local-first, cross-platform CapCut replacement. Scriptable through a JSON-RPC API & MCP."
  homepage "https://github.com/jub0t/Concat"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true

  depends_on macos: :tahoe
  # conflicts_with cask: ""

  app "Concut.app"
  bundle_id = "com.notproton.NotProton"

  zap trash: [
    "~/Library/Application Support/#{bundle_id}",
    "~/Library/Caches/#{bundle_id}",
    "~/Library/HTTPStorages/#{bundle_id}",
    "~/Library/Preferences/#{bundle_id}.plist",
    "~/Library/Saved Application State/#{bundle_id}.savedState",
  ]

  caveats <<~EOS
    #{token} is not notarized by Apple. On first launch macOS will block it:
    open it once, then go to System Settings → Privacy & Security and click
    "Open Anyway". This is only needed once.
  EOS

  # caveats do
  #   unsigned_accessibility 
  # end

end
