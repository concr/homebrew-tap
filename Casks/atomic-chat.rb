cask "atomic-chat" do
  version "2.4.5"
  sha256 "38904ca55b558d4d33027c763dc7d9857e5bf9df6591accd7031ccc6709df807"

  url "https://github.com/AtomicBot-ai/Atomic-Chat/releases/download/v#{version}/Atomic.Chat_#{version}_universal.dmg"
  name "Atomic Chat"
  desc "Local AI app and inference engine for agents"
  homepage "https://atomic.chat/"

  livecheck do
    url :url
    strategy :github_latest
  end

  # auto_updates true

  depends_on arch: [:arm64, :intel]
  depends_on macos: :ventura

  # conflicts_with cask: ""

  app "Atomic Chat.app"

  bundle_id = "chat.atomic.app"

  zap trash: [
    "~/Library/Application Support/#{bundle_id}",
    "~/Library/Caches/#{bundle_id}",
    "~/Library/HTTPStorages/#{bundle_id}",
    "~/Library/Preferences/#{bundle_id}.plist",
    "~/Library/Saved Application State/#{bundle_id}.savedState",
    "~/Library/WebKit/#{bundle_id}",
  ]
end
