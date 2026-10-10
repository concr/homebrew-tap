cask "makemkv" do
  version "2.0.0"
  # Fill in: curl -sL https://www.makemkv.com/download/makemkv_v2.0.0_osx.dmg | shasum -a 256
  sha256 "e3adad095fb9344e23870d99fd9770a187816332c5a2aa1b226c0bd4a922867a"

  url "https://www.makemkv.com/download/makemkv_v#{version}_osx.dmg"
  name "MakeMKV"
  desc "MakeMKV is a format converter, otherwise called transcoder."
  homepage "https://www.makemkv.com/"

  livecheck do
    url "https://www.makemkv.com/download/"
    regex(%r{href=.*?/makemkv[._-]v?(\d+(?:\.\d+)+)[._-]osx\.dmg}i)
  end

  # makemkv runs from 10.7 lion .. but current homebrew is sequoia and up
  depends_on macos: :lion

  app "MakeMKV.app"
  binary "#{appdir}/MakeMKV.app/Contents/MacOS/makemkvcon"
  binary "#{appdir}/MakeMKV.app/Contents/MacOS/mmccextr"
  binary "#{appdir}/MakeMKV.app/Contents/MacOS/mmgplsrv"
  binary "#{appdir}/MakeMKV.app/Contents/MacOS/sdftool"

  # Fill in the bundle ID once installed:
  #   mdls -name kMDItemCFBundleIdentifier -r "/Applications/NotProton.app"
  bundle_id = "com.makemkv.MakeMKV"

  # Find all folders/fileS:
  #   sudo find ~/Library /Library /private/var/folders -iname "*com.makemkv.MakeMKV*" 2>/dev/null
  zap trash: [
    "~/Library/MakeMKV",
    "~/Library/Preferences/#{bundle_id}.plist",
    "~/Library/Saved Application State/com.makemkv.MakeMKV.savedState",
    "~/Movies/.MakeMKV",
  ]

  caveats <<~EOS
    #{token} is not notarized by Apple. On first launch macOS will block it:
    open it once, then go to System Settings → Privacy & Security and click
    "Open Anyway". This is only needed once.

    #{token} is free while in beta. Get your serial here:
    https://forum.makemkv.com/forum/viewtopic.php?t=1053
  EOS
end
