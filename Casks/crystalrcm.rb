cask "crystalrcm" do

  version "1.0.0"
  sha256 "54c6ba29cb976bbd156970c2e710586883072e737f7c54615cb5c8b455ef6cc7"

  url "https://github.com/prayerie/CrystalRCM/releases/download/#{version}/CrystalRCM.#{version}.dmg"
  name "CrystalRCM"
  desc "Enables the Steam Play experience from Linux Steam in the macOS Steam client."
  homepage "https://github.com/prayerie/CrystalRCM"

  livecheck do
    url :url
    strategy :github_latest
  end

  # auto_updates true

  depends_on macos: :ventura  # crystalrcm runs from 12.1 monterey but 13.0 ventura is the lowest we can use
  # conflicts_with cask: ""

  app "CrystalRCM.app"
  bundle_id = "cafe.moya.CrystalRCM"

  zap trash: [
    "~/Library/Application Support/#{bundle_id}",
    "~/Library/Caches/#{bundle_id}",
    "~/Library/HTTPStorages/#{bundle_id}",
    "~/Library/Preferences/#{bundle_id}.plist",
    "~/Library/Saved Application State/#{bundle_id}.savedState",
  ]

  caveats <<~EOS
    #{token} is not notarized by Apple. On first launch macOS will block it:
    open it once, then go to System Settings → Privacy & Security and click
    "Open Anyway". This is only needed once.
  EOS

  # caveats do
  #   unsigned_accessibility 
  # end

end
