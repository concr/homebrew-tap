cask "atomic-chat" do

  version "2.2.29"
  sha256 "48e17fb483877a1f9ce493a25b8826191a3b9c7bbe513590ece39cd50365ef6f"

  url "https://github.com/AtomicBot-ai/Atomic-Chat/releases/download/v#{version}/Atomic.Chat_#{version}_universal.dmg"
  name "Atomic Chat"
  desc "Local AI app and inference engine for agents."
  homepage "https://atomic.chat"

  livecheck do
    url :url
    strategy :github_latest
  end
  
  # auto_updates true

  # depends_on arch: :arm64
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

    "~/Library/WebKit/#{bundle_id}"
  ]

end
