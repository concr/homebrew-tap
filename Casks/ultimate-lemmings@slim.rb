cask "ultimate-lemmings@slim" do

  version "2.4.2,build106"
  sha256 "0f40f16931f4f4e041554887e96e2bdef2c53f434977725ec2def3da24241fa7"

  url "https://github.com/ErikVeland/Lemmings/releases/download/v#{version.csv.first}/UltimateLemmings-#{version.csv.first}-#{version.csv.second}-slim.zip"
  name "Ultimate Lemmings (slim)"
  desc "Unofficial native port of the 2D Lemmings games - no soundtracks included"
  homepage "https://www.reddit.com/r/macgaming/comments/1x0myc9/ultimate_lemmings_all_2d_lemmings_for_modern_macs/"

  livecheck do
    url :url
    regex(/^UltimateLemmings[._-]v?(\d+(?:\.\d+)+)[._-](build\d+)-slim\.zip$/i)
    strategy :github_latest do |json, regex|
      json["assets"]&.map do |asset|
        match = asset["name"]&.match(regex)
        next if match.blank?

        "#{match[1]},#{match[2]}"
      end
    end
  end

  # auto_updates true
  
  # depends_on arch: :arm64
  depends_on macos: :ventura  # runs from 12.3 monterey but 13.0 ventura is the lowest we can use
  conflicts_with cask: "ultimate-lemmings"

  app "Ultimate Lemmings.app"
  bundle_id = "academy.glasscode.lemmings"

  zap trash: [
    "~/Library/Application Support/#{bundle_id}",
    "~/Library/Caches/#{bundle_id}",
    "~/Library/HTTPStorages/#{bundle_id}",
    "~/Library/Preferences/#{bundle_id}.plist",
    "~/Library/Saved Application State/#{bundle_id}.savedState",
  ]

  postflight_steps do
    remove "__MACOSX", recursive: true
  end

end
