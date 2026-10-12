cask "xact-preservation" do

  version "2.59"
  sha256 "cc4849469f460e63797ce0eb50051e5165e9ca3e2d6c1af33559c85b31990fd3"

  url "http://xact.scottcbrown.org/xACT#{version}.zip"
  name "X Audio Compression Toolkit"
  name "xACT"
  desc "Encodes and decodes FLAC, SHN, Monkey’s Audio, TTA, Wavpack, and Apple Lossless files."
  homepage "http://xact.scottcbrown.org"

  livecheck do
    url :homepage
    regex(/href=["']?[^"' >]*?xACT[._-]?v?(\d+(?:\.\d+)+)\.zip/i)
  end

  auto_updates true

  # xact from 10.13 mojave but 13.0 ventura is the lowest we can use
  depends_on macos: :ventura

  conflicts_with cask: "xact"
  app "xACT#{version}/xACT.app"

  # Fill in the bundle ID once installed:
  #   mdls -name kMDItemCFBundleIdentifier -r "/Applications/xACT.app"
  bundle_id = "org.scottcbrown.xact"

  # Find all folder / files:
  #   sudo find ~/Library /Library /private/var/folders -iname "*org.scottcbrown.xact*" 2>/dev/null
  zap trash: [
    "~/Library/Application Support/#{bundle_id}",
    "~/Library/Caches/#{bundle_id}",
    "~/Library/HTTPStorages/#{bundle_id}",
    "~/Library/Preferences/#{bundle_id}.plist",
    "~/Library/Saved Application State/#{bundle_id}.savedState",
  ]

end
