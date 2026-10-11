cask "ultimater-lemmings" do

  version "1.9.1"

  # Fill in: curl -sL https://github.com/ErikVeland/Lemmings/releases/download/v1.9.1/UltimateLemmings-1.9.1-build76.zip | shasum -a 256
  sha256 "3237ad68355107a6f6926c148bacc14312a7989f8a22be82d117f988cd646b26"

  url "https://github.com/ErikVeland/Lemmings/releases/download/v#{version}/UltimateLemmings-#{version}-build76.zip"
  name "Ultimate Lemmings (all soundtracks included)"
  desc "Unofficial native macOS port of the 2D Lemmings games."
  homepage "https://github.com/ErikVeland/Lemmings"

  livecheck do
    url :url
    strategy :github_latest
  end

  # ultimate lemmings runs from 12.3 monterey but homebrew needs 15.0 sequoia or higher
  depends_on macos: :sequoia

  app "Ultimate Lemmings.app"

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
