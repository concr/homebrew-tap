cask "virtual-intel-mac" do

  version "2.0"
  sha256 "3c733ce8cd84b854a0ad5add7f5adfacecf2a0c795b0978da3c4138add2279c3"

  url "https://github.com/nfzerox/VirtualIntelMacOnAppleSilicon/releases/download/#{version}/VirtualIntelMac.#{version}.zip"
  name "Virtual Intel Mac"
  desc "Runs Mojave 10.14, Catalina 10.15 and Big Sur 11 on Apple Silicon."
  homepage "https://github.com/nfzerox/VirtualIntelMacOnAppleSilicon"

  livecheck do
    url :url
    strategy :github_latest
  end

  # auto_updates true

  depends_on arch: [ :arm64, :intel ]
  depends_on macos: :sequoia
  # conflicts_with: cask: ""

  app "Virtual Intel Mac/Virtual Intel Mac.app"
  bundle_id = "com.mac.virtualintelmac"

  zap trash: [
    "~/Library/Application Support/#{bundle_id}",
    "~/Library/Caches/#{bundle_id}",
    "~/Library/HTTPStorages/#{bundle_id}",
    "~/Library/Preferences/#{bundle_id}.plist",
    "~/Library/Saved Application State/#{bundle_id}.savedState",
  ]

  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Virtual Intel Mac.app"]
    run "/bin/echo", args: ["🦠 Removed quarantine from {{token}}."], print_stdout: true
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
