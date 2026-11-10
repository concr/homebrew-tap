cask "xld-preservation" do
  version "20250302"
  sha256 "0032a5470ea4e32a11a35b8077ebf4986102891f8eb82743094f2c6621ad8aeb"

  url "https://downloads.sourceforge.net/xld/xld-#{version}.dmg"
  name "X Lossless Decoder"
  name "XLD"
  desc "Lossless audio decoder"
  homepage "https://tmkk.undo.jp/xld/index_e.html"

  livecheck do
    url "https://svn.code.sf.net/p/xld/code/appcast/xld-appcast_e.xml"
    strategy :sparkle, &:short_version
  end

  auto_updates true
  conflicts_with cask: "xld"
  depends_on arch: [:arm64, :intel]
  depends_on macos: :ventura # runs from 10.4 lion but 13.0 ventura is the lowest we can use

  app "XLD.app"
  bundle_id = "jp.tmkk.XLD"

  command_wrapper "xld",
                  executable: "#{appdir}/XLD.app/Contents/MacOS/XLD",
                  args:       "--cmdline"

  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/XLD.app"]
    run "/bin/echo", args: ["🦠 Removed quarantine from {{token}}."], print_stdout: true
  end

  zap trash: [
    "~/Library/Application Support/#{bundle_id}",
    "~/Library/Application Support/com.apple.sharedfilelist/com.apple.LSSharedFileList.ApplicationRecentDocuments/#{bundle_id}.sfl*",
    "~/Library/Application Support/XLD",
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
