cask "xact-preservation" do

  version "2.60"
  sha256 "b450eb6465fc4182e56a8db16d004905ecf98ac9c52f7954ad53e56b883f5e76"

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
  
  depends_on macos: :ventura  # xact from 10.13 mojave but 13.0 ventura is the lowest we can use
  conflicts_with cask: "xact"

  app "xACT#{version}/xACT.app"
  bundle_id = "org.scottcbrown.xact"

  zap trash: [
    "~/Library/Application Support/#{bundle_id}",
    "~/Library/Caches/#{bundle_id}",
    "~/Library/HTTPStorages/#{bundle_id}",
    "~/Library/Preferences/#{bundle_id}.plist",
    "~/Library/Saved Application State/#{bundle_id}.savedState",
  ]

end
