cask "atomic-chat" do
  version "2.3.5"
  sha256 "b3052671950e4437bf73d8275b9c959b819b79d90259f5bf7904b3660f663599"

  url "https://github.com/AtomicBot-ai/Atomic-Chat/releases/download/v#{version}/Atomic.Chat_#{version}_universal.dmg"
  name "Atomic Chat"
  desc "Local AI app and inference engine for agents"
<<<<<<< Updated upstream
  homepage "https://atomic.chat"
=======
  homepage "https://atomic.chat/"
>>>>>>> Stashed changes

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
