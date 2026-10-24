cask "virtual-intel-mac"

  version "1.0"
  sha256 "87d4dc3f77568c545451c3484dc639ee814cd3a47590c7ccf7d0ed8f61f83325"

  url "https://github.com/nfzerox/VirtualIntelMacOnAppleSilicon/releases/download/#{version}/VirtualIntelMac.#{version}.zip"
  name "Virtual Intel Mac"
  desc "Runs macOS Mojave, Catalina and Big Sur on Apple Silicon"
  homepage "https://github.com/nfzerox/VirtualIntelMacOnAppleSilicon"

  livecheck do
    url :url
    strategy :github_latest
  end

  # auto_updates true

  depends_on macos: :sequoia
  # conflicts_with: cask: ""

  app "Virtual Intel Mac/Virtual Intel Mac.app"
  bundle_id = "com.mac.virtualintelmac"

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

    Run the commmand m5uploader from terminal and then notarize it in settings.
  EOS

  # caveats do
  #   unsigned_accessibility 
  # end

end
