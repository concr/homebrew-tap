cask "xld-preservation" do

  version "20250302"
  sha256 "0032a5470ea4e32a11a35b8077ebf4986102891f8eb82743094f2c6621ad8aeb"

  url "https://downloads.sourceforge.net/xld/xld-#{version}.dmg"
  name "X Lossless Decoder"
  name "XLD"
  desc "Lossless audio decoder."
  homepage "https://tmkk.undo.jp/xld/index_e.html"

  livecheck do
    url "https://svn.code.sf.net/p/xld/code/appcast/xld-appcast_e.xml"
    strategy :sparkle, &:short_version
  end

  auto_updates true

  # xld runs from 10.4 lion but homebrew needs 15.0 sequoia or higher
  depends_on macos: :sequoia

  conflicts_with cask: "xld"

  app "XLD.app"

  command_wrapper "xld",
    executable: "#{appdir}/XLD.app/Contents/MacOS/XLD",
    args: "--cmdline"

  # Fill in the bundle ID once installed:
  #   mdls -name kMDItemCFBundleIdentifier -r "/Applications/XLD.app"
  bundle_id = "jp.tmkk.XLD"

  # Find all folders/fileS:
  #   sudo find ~/Library /Library /private/var/folders -iname "*jp.tmkk.XLD*" 2>/dev/null
  zap trash: [
    "~/Library/Application Support/com.apple.sharedfilelist/com.apple.LSSharedFileList.ApplicationRecentDocuments/#{bundle_id}.sfl*",
    "~/Library/Application Support/XLD",
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
