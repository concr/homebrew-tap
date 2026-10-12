cask "ultimate-lemmings" do

  version "1.9.4,build79"

  # Fill in: curl -sL https://github.com/ErikVeland/Lemmings/releases/download/v1.9.3/UltimateLemmings-1.9.3-build78.zip | shasum -a 256
  sha256 "8ff1403b8044abc4a2ef9f8d27b9c2b89a9642fc0a3706fe722b7d43ee8db49c"

  url "https://github.com/ErikVeland/Lemmings/releases/download/v#{version.csv.first}/UltimateLemmings-#{version.csv.first}-#{version.csv.second}.zip"
  name "Ultimate Lemmings"
  desc "Unofficial native macOS port of the 2D Lemmings games. All soundtracks included."
  homepage "https://www.reddit.com/r/macgaming/comments/1x0myc9/ultimate_lemmings_all_2d_lemmings_for_modern_macs/"

  livecheck do
    url :url
    regex(/^UltimateLemmings[._-]v?(\d+(?:\.\d+)+)[._-](build\d+)\.zip$/i)
    strategy :github_latest do |json, regex|
      json["assets"]&.map do |asset|
        match = asset["name"]&.match(regex)
        next if match.blank?

        "#{match[1]},#{match[2]}"
      end
    end
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
