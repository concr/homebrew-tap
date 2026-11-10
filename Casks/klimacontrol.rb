cask "klimacontrol" do

  version "1.2.0.0"
  sha256 "e88cb977a6dbbbf1c9db845eedb4e74c5481cb035613a489e29ba355b1942998"

  url "https://github.com/mlafx/Klimacontrol/releases/download/v#{version}/Klimacontrol-#{version}-mac.dmg"
  name "Klimacontrol"
  desc "Midea-PortaSplit-Steuerung für macOS und Windows - lokal im LAN, Cloud optional."
  homepage "https://github.com/mlafx/Klimacontrol"

  livecheck do
    url :url
    strategy :github_latest
  end
  
  # auto_updates true

  depends_on arch: [ :arm64, :intel ]
  depends_on macos: :sequoia
  # conflicts_with cask: ""

  app "Klimacontrol.app"
  bundle_id = "de.mlafx.klimacontrol"

  zap trash: [
    "~/Library/Application Support/#{bundle_id}",
    "~/Library/Caches/#{bundle_id}",
    "~/Library/HTTPStorages/#{bundle_id}",
    "~/Library/Preferences/#{bundle_id}.plist",
    "~/Library/Saved Application State/#{bundle_id}.savedState"
  ]

end
