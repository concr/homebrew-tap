cask "nx2apple@rc" do

  version "0.8.0,7"
  sha256 "4cbb5eb69ba2934554f217a2796f8382eb0fb81636bdd7319a834f788bc50595"

  url "https://github.com/LNPANDY/NX2Apple/releases/download/v#{version.csv.first}-rc#{version.csv.second}/NS-Port-Builder-macOS-arm64.zip"
  name "NX2Apple (Release Candidate)"
  desc "Play your own Switch games on iPhone/iPad — one-click macOS app, no terminal."
  homepage "https://github.com/LNPANDY/NX2Apple"

  livecheck do
    url :url
    regex(/^v?(\d+(?:\.\d+)+)-rc(\d+)$/i)
    # github_latest skips prereleases; a block makes github_releases keep them
    strategy :github_releases do |json, regex|
      json.map do |release|
        next if release["draft"]

        match = release["tag_name"]&.match(regex)
        "#{match[1]},#{match[2]}" if match
      end
    end
  end

  # auto_updates true

  depends_on arch: :arm64
  depends_on macos: :ventura
  conflicts_with cask: "nx2apple"

  app "NS Port Builder.app"
  bundle_id = "org.nxnative.NSPortBuilder"

  zap trash: [
    "~/Library/Application Support/#{bundle_id}",
    "~/Library/Caches/#{bundle_id}",
    "~/Library/HTTPStorages/#{bundle_id}",
    "~/Library/Preferences/#{bundle_id}.plist",
    "~/Library/Saved Application State/#{bundle_id}.savedState",
  ]

  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/{{token}}.app"]
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
