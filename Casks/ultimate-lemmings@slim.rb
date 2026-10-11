cask "ultimate-lemmings@slim" do

  version "1.9.1"

  # Fill in: curl -sL https://github.com/ErikVeland/Lemmings/releases/download/v1.9.1/UltimateLemmings-1.9.1-build76-slim.zip | shasum -a 256
  sha256 "eeee35462b5832b40ddedbe5ba09413719d5494aac2181cfc3b695f6727214c5"

  url "https://github.com/ErikVeland/Lemmings/releases/download/v#{version}/UltimateLemmings-#{version}-build76-slim.zip"
  name "Ultimate Lemmings (slim)"
  desc "Unofficial native macOS port of the 2D Lemmings games. No soundtracks included."
  homepage "https://github.com/ErikVeland/Lemmings"

  livecheck do
    url :url
    strategy :github_latest
  end

  # ultimate lemmings runs from 12.3 monterey but homebrew needs 15.0 sequoia or higher
  depends_on macos: :sequoia

  app "Ultimate Lemmings.app"

  postflight_steps do
    remove "__MACOSX", recursive: true
  end

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

end
