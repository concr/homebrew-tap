cask "atomic-chat" do
  version "2.4.7"
  sha256 "3926c1e504ae6fc31854451a7b528e85eb9f1667cd44042ab674ba720e6531fc"

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
