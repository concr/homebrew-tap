cask "atomic-chat" do

  version "2.2.26"
  sha256 "06d04fce08a7b9f8301e680a4ac7524519579341fe3ba3873ba20e2fe1b86b4b"

  url "https://github.com/AtomicBot-ai/Atomic-Chat/releases/download/v#{version}/Atomic.Chat_#{version}_universal.dmg"
  name "Atomic Chat"
  desc "Local AI app and inference engine for agents."
  homepage "https://atomic.chat"

  livecheck do
    url :url
    strategy :github_latest
  end
  
  # auto_updates true

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
