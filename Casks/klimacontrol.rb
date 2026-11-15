cask "klimacontrol" do
  version "1.3.0.1"
  sha256 "4110d11db34a0712df9816a0b847f6ea664be5bb8f119eac7519404a4562b324"

  url "https://github.com/mlafx/Klimacontrol/releases/download/v#{version}/Klimacontrol-#{version}-mac.dmg"
  name "Klimacontrol"
  desc "Midea-PortaSplit-Steuerung - lokal im LAN, Cloud optional"
  homepage "https://github.com/mlafx/Klimacontrol"

  livecheck do
    url :url
    strategy :github_latest
  end

  # auto_updates true

  depends_on arch: [:arm64, :intel]
  depends_on macos: :sequoia

  # conflicts_with cask: ""

  app "Klimacontrol.app"

  bundle_id = "de.mlafx.klimacontrol"

  zap trash: [
    "~/Library/Application Support/#{bundle_id}",
    "~/Library/Caches/#{bundle_id}",
    "~/Library/HTTPStorages/#{bundle_id}",
    "~/Library/Preferences/#{bundle_id}.plist",
    "~/Library/Saved Application State/#{bundle_id}.savedState",
  ]
end
