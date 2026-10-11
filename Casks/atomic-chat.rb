cask "atomic-chat" do

  version "2.2.3"

  # Fill in: curl -sL https://github.com/prayerie/CrystalRCM/releases/download/1.0.0/CrystalRCM.1.0.0.dmg | shasum -a 256
  sha256 "54c6ba29cb976bbd156970c2e710586883072e737f7c54615cb5c8b455ef6cc7"

  url "https://github.com/AtomicBot-ai/Atomic-Chat/releases/download/v#{version}/Atomic.Chat_#{version}_universal.dmg",
    verified: "https://github.com/AtomicBot-ai/Atomic-Chat/"
  name "Atomic Chat"
  desc "Local AI app and inference engine for agents."
  homepage "https://atomic.chat"

  livecheck do
    url :url
    strategy :github_latest
  end
  
  # atomic chat runs from 10.13 high sierra but homebrew needs 15.0 sequoia or higher
  depends_on macos: :sequoia

  app "Atomic Chat.app"

  # Fill in the bundle ID once installed:
  #   mdls -name kMDItemCFBundleIdentifier -r "/Applications/Atomic Chat.app"
  bundle_id = "chat.atomic.app"

  # Find all folder / files:
  #   sudo find ~/Library /Library /private/var/folders -iname "*chat.atomic.app*" 2>/dev/null
  zap trash: [
    "~/Library/Caches/#{bundle_id}",
    "~/Library/HTTPStorages/#{bundle_id}",
    "~/Library/Preferences/#{bundle_id}.plist",
    "~/Library/Saved Application State/#{bundle_id}.savedState",

    "~/Library/WebKit/#{bundle_id}"
  ]

end
