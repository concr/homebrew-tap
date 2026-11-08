cask "klimacontrol" do

  version "1.2.0.0"
  sha256 "e88cb977a6dbbbf1c9db845eedb4e74c5481cb035613a489e29ba355b1942998"

  url "https://github.com/mlafx/Klimacontrol/releases/download/v#{version}/Klimacontrol-#{version}-mac.dmg"
  name "Klimacontrol"
  desc "Midea-PortaSplit-Steuerung für macOS und Windows – lokal im LAN, Cloud optional."
  homepage "https://github.com/mlafx/Klimacontrol"

  livecheck do
    url :url
    strategy :github_latest
  end
  
  # auto_updates true

  depends_on arch: [ :arm64, :intel ]
  depends_on macos: :ventura
  # conflicts_with cask: ""

  app "Klimacontrol.app"
  bundle_id = "chat.atomic.app"

  zap trash: [
    "~/Library/Application Support/#{bundle_id}",
    "~/Library/Caches/#{bundle_id}",
    "~/Library/HTTPStorages/#{bundle_id}",
    "~/Library/Preferences/#{bundle_id}.plist",
    "~/Library/Saved Application State/#{bundle_id}.savedState",

    "~/Library/WebKit/#{bundle_id}"
  ]

  postflight_steps do
    run "/usr/bin/xattr", args: [ "-dr", "com.apple.quarantine", "{{appdir}}/AirPortKonfigurator.app" ]
    run "/bin/echo", args: [ "🦠 Removed quarantine from {{token}}." ], print_stdout: true
  end

  # caveats <<~EOS
  #   #{token} is not notarized by Apple. On first launch macOS will block it:
  #   open it once, then go to System Settings → Privacy & Security and click
  #   "Open Anyway". This is only needed once.
  #
  #   Run the commmand m5uploader from terminal and then notarize it in settings.
  # EOS

  # caveats do
  #   unsigned_accessibility 
  # end

end
