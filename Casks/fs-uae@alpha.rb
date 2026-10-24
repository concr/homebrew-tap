cask "fs-uae@alpha" do

  arch arm: "arm64", intel: "x86_64"
  
  version "5.0.7"
  
  # Fill in: curl -sL https://fs-uae.net/alpha/5.0.7/FS-UAE-5.0.7-arm64-apple-darwin.dmg | shasum -a 256
  #          curl -sL https://fs-uae.net/alpha/5.0.7/FS-UAE-5.0.7-x86_64-apple-darwin.dmg | shasum -a 256
  sha256 arm:   "6a98d9a17c3a3e0e8b1b63cce7c2a809ac77cd8b98f9758c9797bcd9ec62082d",
         intel: "23be86a459923b156ebd4f2954c8c544216d0d8a1cdd7d58ad5c58579340df6d"

  url "https://fs-uae.net/alpha/#{version}/FS-UAE-#{version}-#{arch}-apple-darwin.dmg"
  name "FS-UAE"
  desc "Frode Solheim's Universal Amiga Emulator"
  homepage "https://fs-uae.net/"

  livecheck do
    url "https://fs-uae.net/alpha/"
    regex(%r{href=["']?v?(\d+(?:\.\d+)+)/?["' >]}i)
  end

  # auto_updates true

  depends_on macos: :ventura  # fs-uae@alpha runs from 10.13 high sierra but 13.0 ventura is the lowest we can use
  conflicts_with cask: "fs-uae-emulator"

  app "FS-UAE.app"
  bundle_id = "net.fs-uae.FS-UAE"

  zap trash: [
    "~/Library/Application Support/#{bundle_id}",
    "~/Library/Caches/#{bundle_id}",
    "~/Library/HTTPStorages/#{bundle_id}",
    "~/Library/Preferences/#{bundle_id}.plist",
    "~/Library/Saved Application State/#{bundle_id}.savedState",
  ]

end
