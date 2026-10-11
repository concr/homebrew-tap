cask "ultimate-lemmings@slim" do

  version "1.9.2"
  version_build = "build77"

  # Fill in: curl -sL https://github.com/ErikVeland/Lemmings/releases/download/v1.9.2/UltimateLemmings-1.9.2-build77-slim.zip | shasum -a 256
  sha256 "a7cf15e7cf54b20e0e85e7aacd1491de56a577bbacbdaae89e07debb3dda5eb7"

  url "https://github.com/ErikVeland/Lemmings/releases/download/v#{version}/UltimateLemmings-#{version}-#{version_build}-slim.zip",
    verified: "https://github.com/ErikVeland/Lemmings"
  name "Ultimate Lemmings (slim)"
  desc "Unofficial native macOS port of the 2D Lemmings games. All soundtracks included."
  homepage "https://www.reddit.com/r/macgaming/comments/1x0myc9/ultimate_lemmings_all_2d_lemmings_for_modern_macs/"

  livecheck do
    url :url
    strategy :github_latest
  end

  # ultimate lemmings runs from 12.3 monterey but homebrew needs 15.0 sequoia or higher
  depends_on macos: :monterey

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
    "~/Library/Caches/#{bundle_id}",
    "~/Library/HTTPStorages/#{bundle_id}",
    "~/Library/Preferences/#{bundle_id}.plist",
    "~/Library/Saved Application State/#{bundle_id}.savedState",
  ]


end
