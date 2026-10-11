cask "ultimate-lemmings" do

  version "1.9.2,build77"

  # Fill in: curl -sL https://github.com/ErikVeland/Lemmings/releases/download/v1.9.2/UltimateLemmings-1.9.2-build77.zip | shasum -a 256
  sha256 "78458cf2756934ad64cda83bf48fd3ab9f983cdd48ec2c0405d13290d100f789"

  url "https://github.com/ErikVeland/Lemmings/releases/download/v#{version.csv.first}/UltimateLemmings-#{version.csv.first}-#{version.csv.second}.zip"
  name "Ultimate Lemmings"
  desc "Unofficial native macOS port of the 2D Lemmings games. All soundtracks included."
  homepage "https://www.reddit.com/r/macgaming/comments/1x0myc9/ultimate_lemmings_all_2d_lemmings_for_modern_macs/"

  livecheck do
    url :url
    strategy :github_latest
  end

  # ultimate lemmings runs from 12.3 monterey but 13.0 ventura is the lowest we can use
  depends_on macos: :ventura
  conflicts_with cask: "ultimate-lemmings@slim"

  app "Ultimate Lemmings.app"

  postflight_steps do
    remove "__MACOSX", recursive: true
  end

  # Fill in the bundle ID once installed:
  #   mdls -name kMDItemCFBundleIdentifier -r "/Applications/Ultimate Lemmings.app"
  bundle_id = "academy.glasscode.lemmings"

  # Find all folder / files:
  #   sudo find ~/Library /Library /private/var/folders -iname "*academy.glasscode.lemmings*" 2>/dev/null
  zap trash: [
    "~/Library/Application Support/#{bundle_id}",
    "~/Library/Caches/#{bundle_id}",
    "~/Library/HTTPStorages/#{bundle_id}",
    "~/Library/Preferences/#{bundle_id}.plist",
    "~/Library/Saved Application State/#{bundle_id}.savedState",
  ]

end
