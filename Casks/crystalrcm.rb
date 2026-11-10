cask "crystalrcm" do
  version "1.0.0"
  sha256 "54c6ba29cb976bbd156970c2e710586883072e737f7c54615cb5c8b455ef6cc7"

  url "https://github.com/prayerie/CrystalRCM/releases/download/#{version}/CrystalRCM.#{version}.dmg"
  name "CrystalRCM"
<<<<<<< Updated upstream
  desc "Enables the Steam Play experience from Linux Steam in the Steam client"
=======
  desc "Enables the Steam Play experience from Linux Steam in the macOS Steam client" # rubocop:todo Cask/Desc
>>>>>>> Stashed changes
  homepage "https://github.com/prayerie/CrystalRCM"

  livecheck do
    url :url
    strategy :github_latest
  end

  # auto_updates true

  depends_on arch: [:arm64, :intel]
  depends_on macos: :ventura # runs from 12.1 monterey but 13.0 ventura is the lowest we can use

  # conflicts_with cask: ""

  app "CrystalRCM.app"

  bundle_id = "cafe.moya.CrystalRCM"

  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/CrystalRCM.app"]
    run "/bin/echo", args: ["🦠 Removed quarantine from {{token}}."], print_stdout: true
  end

  zap trash: [
    "~/Library/Application Support/#{bundle_id}",
    "~/Library/Caches/#{bundle_id}",
    "~/Library/HTTPStorages/#{bundle_id}",
    "~/Library/Preferences/#{bundle_id}.plist",
    "~/Library/Saved Application State/#{bundle_id}.savedState",
  ]

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
