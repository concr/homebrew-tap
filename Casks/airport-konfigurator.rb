cask "airport-konfigurator" do

  version "1.0"

  # Fill in: curl -sL https://www.iwerkstatt-repair.de/wp-content/uploads/2026/07/AirPortKonfigurator.zip | shasum -a 256
  # sha256 "8437baa05ded5720cd7f2bc5c2d371cc3a148de90d342de89be8acecc30d87af"
  # Use `sha256 :no_check` when URL is unversioned.
  sha256 :no_check

  # The download URL is not versioned, so a new release changes the checksum
  # without changing the URL. Bump `version` and `sha256` together.
  url "https://www.iwerkstatt-repair.de/wp-content/uploads/2026/07/AirPortKonfigurator.zip"
  name "AirPort Konfigurator"
  desc "Configure and manage AirPort base stations without AirPort Utility."
  homepage "https://www.iwerkstatt-repair.de/software/airport-konfigurator/"

  livecheck do
    url :homepage
    regex(/Version\s+v?(\d+(?:\.\d+)+)/i)
  end

  depends_on macos: :tahoe

  app "AirPortKonfigurator.app"

  # Fill in the bundle ID once installed:
  #   mdls -name kMDItemCFBundleIdentifier -r "/Applications/AirPort Konfigurator.app"
  bundle_id = "de.iwerkstatt.airportkonfigurator"

  # Find all folders/fileS:
  #   sudo find ~/Library /Library /private/var/folders -iname "*de.iwerkstatt.airportkonfigurator*" 2>/dev/null
  zap trash: [
    "~/Library/Application Scripts/#{bundle_id}",
    "~/Library/Containers/#{bundle_id}",
  ]

  caveats <<~EOS
    #{token} is not notarized by Apple. On first launch macOS will block it:
    open it once, then go to System Settings → Privacy & Security and click
    "Open Anyway". This is only needed once.

    #{token} requires macOS 26.6 or newer.
EOS
  EOS

  # caveats do
  #   unsigned_accessibility 
  # end

end
