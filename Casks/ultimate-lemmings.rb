cask "ultimate-lemmings" do

  version "2.2.2,build99"
  sha256 "ac9b46e195296421cf0a2fde132f4d4442726edd0662da12bf9a2972a1937d9a"

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

  # auto_updates true
  
  depends_on macos: :ventura  # ultimate lemmings runs from 12.3 monterey but 13.0 ventura is the lowest we can use
  conflicts_with cask: "ultimate-lemmings@slim"

  app "Ultimate Lemmings.app"
  bundle_id = "academy.glasscode.lemmings"

  postflight_steps do
    remove "__MACOSX", recursive: true
  end

  zap trash: [
    "~/Library/Application Support/#{bundle_id}",
    "~/Library/Caches/#{bundle_id}",
    "~/Library/HTTPStorages/#{bundle_id}",
    "~/Library/Preferences/#{bundle_id}.plist",
    "~/Library/Saved Application State/#{bundle_id}.savedState",
  ]

end
