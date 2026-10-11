cask "ultimate-lemmings@slim" do

  version "1.9.2"

  # Fill in: curl -sL https://github.com/ErikVeland/Lemmings/releases/download/v1.9.2/UltimateLemmings-1.9.2-build76-slim.zip | shasum -a 256
  sha256 "0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5"

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
