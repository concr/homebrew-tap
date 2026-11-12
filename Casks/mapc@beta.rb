cask "mapc@beta" do
  version "1.1.27"
  sha256 "e34b9b8ab4b7a80beeb523042db346be34391731df4e06d118fe9323f06949b7"

  url "https://github.com/abduzeedo/mapc-site/releases/download/v#{version}/MaPC.dmg"
  name "MaPC"
  desc "Connect Steam, Epic, GOG, Amazon and EA. No Wine, nothing to tinker with"
  homepage "https://mapc.games/"

  livecheck do
    url :url
    strategy :github_latest
  end

  # auto_updates true

  depends_on arch: [:arm64, :intel]
  depends_on macos: :sequoia

  # conflicts_with cask: ""

  app "MaPC.app"

  bundle_id = "games.mapc.app"

  zap trash: [
    "~/Library/Application Support/#{bundle_id}",
    "~/Library/Caches/#{bundle_id}",
    "~/Library/HTTPStorages/#{bundle_id}",
    "~/Library/Preferences/#{bundle_id}.plist",
    "~/Library/Saved Application State/#{bundle_id}.savedState",
  ]
end
