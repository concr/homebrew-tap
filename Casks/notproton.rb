cask "notproton" do

  version "1.1.7"

  # Fill in: curl -sL https://github.com/NotProtonNot/NotProton/releases/download/v1.1.7/NotProton.zip | shasum -a 256
  sha256 "df116f5185fb57b6f6f8ff5f593b9851edb697a01777e403e1fd23185f9bdbff"

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
