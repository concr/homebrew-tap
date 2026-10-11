cask "c-notproton" do
  version "1.1.4"
  # Fill in: curl -sL https://github.com/NotProtonNot/NotProton/releases/download/v1.1.4/NotProton.zip | shasum -a 256
  sha256 "dabd725e5409b9dbc8fa8ab4e39b54d28ea6a2fabf647ae9801e2a52dc2f64f4"

  url "https://github.com/NotProtonNot/NotProton/releases/download/v#{version}/NotProton.zip"
  name "NotProton"
  desc "NotProton enables the Steam Play experience from Linux Steam in the macOS Steam client."
  homepage "https://github.com/NotProtonNot/NotProton"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :tahoe"
  app "NotProton.app"

  # Fill in the bundle ID once installed:
  #   mdls -name kMDItemCFBundleIdentifier -r "/Applications/NotProton.app"
  bundle_id = "com.notproton.NotProton"

  # Find all folders/fileS:
  #   sudo find ~/Library /Library /private/var/folders -iname "*com.notproton.NotProton*" 2>/dev/null
  zap trash: [
    "~/Library/Preferences/#{bundle_id}.plist",
    "~/Library/HTTPStorages/#{bundle_id}",
    "~/Library/HTTPStorages/#{bundle_id}.binarycookies",
    "~/Library/Caches/#{bundle_id}",
  ]

  caveats <<~EOS
    #{token} is not notarized by Apple. On first launch macOS will block it:
    open it once, then go to System Settings → Privacy & Security and click
    "Open Anyway". This is only needed once.
  EOS
end
