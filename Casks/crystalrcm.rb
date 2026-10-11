cask "crystalrcm" do

  version "1.0.0"

  # Fill in: curl -sL https://github.com/prayerie/CrystalRCM/releases/download/1.0.0/CrystalRCM.1.0.0.dmg | shasum -a 256
  sha256 "dabd725e5409b9dbc8fa8ab4e39b54d28ea6a2fabf647ae9801e2a52dc2f64f4"

  url "https://github.com/prayerie/CrystalRCM/releases/download/#{version}/CrystalRCM.#{version}.dmg"
  name "CrystalRCM"
  desc "Enables the Steam Play experience from Linux Steam in the macOS Steam client."
  homepage "https://github.com/prayerie/CrystalRCM"

  livecheck do
    url :url
    strategy :github_latest
  end

  # ultimate lemmings runs from 12.1 monterey but homebrew needs 15.0 sequoia or higher
  depends_on macos: :sequoia

  app "CrystalRCM.app"

  # Fill in the bundle ID once installed:
  #   mdls -name kMDItemCFBundleIdentifier -r "/Applications/NotProton.app"
  bundle_id = "cafe.moya.CrystalRCM"

  # Find all folder / files:
  #   sudo find ~/Library /Library /private/var/folders -iname "*cafe.moya.CrystalRCM*" 2>/dev/null
  zap trash: [
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
