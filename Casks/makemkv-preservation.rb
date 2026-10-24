cask "makemkv-preservation" do

  version "2.0.0"
  sha256 "e3adad095fb9344e23870d99fd9770a187816332c5a2aa1b226c0bd4a922867a"

  url "https://www.makemkv.com/download/makemkv_v#{version}_osx.dmg"
  name "MakeMKV"
  desc "Video format converter, otherwise called transcoder."
  homepage "https://www.makemkv.com/"

  livecheck do
    url "https://www.makemkv.com/download/"
    regex(%r{href=.*?/makemkv[._-]v?(\d+(?:\.\d+)+)[._-]osx\.dmg}i)
  end

  # auto_updates true

  depends_on macos: :ventura  # makemkv runs from 10.7 lion but 13.0 ventura is the lowest we can use
  conflicts_with cask: "makemkv"

  app "MakeMKV.app"
  bundle_id = "com.makemkv.MakeMKV"

  binary "#{appdir}/MakeMKV.app/Contents/MacOS/makemkvcon"
  binary "#{appdir}/MakeMKV.app/Contents/MacOS/mmccextr"
  binary "#{appdir}/MakeMKV.app/Contents/MacOS/mmgplsrv"
  binary "#{appdir}/MakeMKV.app/Contents/MacOS/sdftool"

  zap trash: [
    "~/Library/Application Support/#{bundle_id}",
    "~/Library/Caches/#{bundle_id}",
    "~/Library/HTTPStorages/#{bundle_id}",
    "~/Library/Preferences/#{bundle_id}.plist",
    "~/Library/Saved Application State/#{bundle_id}.savedState",

    "~/Library/MakeMKV",
    "~/Movies/.MakeMKV",
  ]

  caveats <<~EOS
    #{token} is not notarized by Apple. On first launch macOS will block it:
    open it once, then go to System Settings → Privacy & Security and click
    "Open Anyway". This is only needed once.

    #{token} is free while in beta. Get your serial here:
    https://forum.makemkv.com/forum/viewtopic.php?t=1053
  EOS

  # caveats do
  #   unsigned_accessibility 
  # end

end
