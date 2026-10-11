cask "notproton" do

  version "1.1.5"

  # Fill in: curl -sL https://github.com/NotProtonNot/NotProton/releases/download/v1.1.5/NotProton.zip | shasum -a 256
  sha256 "a2fd1b4e87dbc9526f48509301229cde151082bfdae456f75fd3ecc1c60a7a27"

  url "https://github.com/NotProtonNot/NotProton/releases/download/v#{version}/NotProton.zip"
  name "NotProton"
  desc "Enables the Steam Play experience from Linux Steam in the macOS Steam client."
  homepage "https://github.com/NotProtonNot/NotProton"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :tahoe

  app "NotProton.app"

  # Fill in the bundle ID once installed:
  #   mdls -name kMDItemCFBundleIdentifier -r "/Applications/NotProton.app"
  bundle_id = "com.notproton.NotProton"

  # Find all folder / files:
  #   sudo find ~/Library /Library /private/var/folders -iname "*com.notproton.NotProton*" 2>/dev/null
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
