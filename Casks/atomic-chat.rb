cask "atomic-chat" do

  version "2.2.3"

  # Fill in: curl -sL https://github.com/AtomicBot-ai/Atomic-Chat/releases/download/v2.2.3/Atomic.Chat_2.2.3_universal.dmg | shasum -a 256
  sha256 "8b0eca28792c727b1f155fb234e9c6a4f09d8d13f68f405174144a447962289c"

  url "https://github.com/AtomicBot-ai/Atomic-Chat/releases/download/v#{version}/Atomic.Chat_#{version}_universal.dmg"
  name "Atomic Chat"
  desc "Local AI app and inference engine for agents."
  homepage "https://atomic.chat"

  livecheck do
    url :url
    strategy :github_latest
  end
  
  # atomic chat runs from 10.13 high sierra but 13.0 ventura is the lowest we can use
  depends_on macos: :ventura
  app "Atomic Chat.app"

  # Fill in the bundle ID once installed:
  #   mdls -name kMDItemCFBundleIdentifier -r "/Applications/Atomic Chat.app"
  bundle_id = "chat.atomic.app"

  # Find all folder / files:
  #   sudo find ~/Library /Library /private/var/folders -iname "*chat.atomic.app*" 2>/dev/null
  zap trash: [
    "~/Library/Application Support/#{bundle_id}",
    "~/Library/Caches/#{bundle_id}",
    "~/Library/HTTPStorages/#{bundle_id}",
    "~/Library/Preferences/#{bundle_id}.plist",
    "~/Library/Saved Application State/#{bundle_id}.savedState",

    "~/Library/WebKit/#{bundle_id}"
  ]

end
