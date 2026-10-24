cask "airport-konfigurator" do

  version "1.0"
  sha256 :no_check

  url "https://www.iwerkstatt-repair.de/wp-content/uploads/2026/07/AirPortKonfigurator.zip"
  name "AirPort Konfigurator"
  desc "Configure and manage AirPort base stations without AirPort Utility."
  homepage "https://www.iwerkstatt-repair.de/software/airport-konfigurator/"

  livecheck do
    url :homepage
    regex(/Version\s+v?(\d+(?:\.\d+)+)/i)
  end

  # auto_updates true

  depends_on macos: :tahoe
  # conflicts_with cask: "d"

  app "AirPortKonfigurator.app"
  bundle_id = "de.iwerkstatt.airportkonfigurator"

  zap trash: [
    "~/Library/Application Support/#{bundle_id}",
    "~/Library/Caches/#{bundle_id}",
    "~/Library/HTTPStorages/#{bundle_id}",
    "~/Library/Preferences/#{bundle_id}.plist",
    "~/Library/Saved Application State/#{bundle_id}.savedState",

    "~/Library/Application Scripts/#{bundle_id}",
    "~/Library/Containers/#{bundle_id}",
  ]

  caveats <<~EOS
    #{token} is not notarized by Apple. On first launch macOS will block it:
    open it once, then go to System Settings → Privacy & Security and click
    "Open Anyway". This is only needed once.

    #{token} requires macOS 26.6 or newer.
  EOS

  # caveats do
  #   unsigned_accessibility 
  # end

end
