cask "fs-uae@alpha" do

  arch arm: "arm64", intel: "x86_64"
  
  version "5.0.6"
  
  # Fill in: curl -sL https://fs-uae.net/alpha/5.0.6/FS-UAE-5.0.6-arm64-apple-darwin.dmg | shasum -a 256
  #          curl -sL https://fs-uae.net/alpha/5.0.6/FS-UAE-5.0.6-x86_64-apple-darwin.dmg | shasum -a 256
  sha256 arm:   "1d03fe37c0888ec8f67dfca51ed5b021449aebb73ea4eaf72114ee2a827ff71a",
         intel: "ce8e2381846163472dfa28d2321a6f6fcd4e901f817d4233443b15ab6ab75e1b"

  url "https://fs-uae.net/alpha/#{version}/FS-UAE-#{version}-#{arch}-apple-darwin.dmg"
  name "FS-UAE"
  desc "Frode Solheim's Universal Amiga Emulator"
  homepage "https://fs-uae.net/"

  livecheck do
    url "https://fs-uae.net/alpha/"
    regex(%r{href=["']?v?(\d+(?:\.\d+)+)/?["' >]}i)
  end

  # dmde runs from 10.13 mojave but 13.0 ventura is the lowest we can use
  depends_on macos: :ventura
  app "FS-UAE.app"

  # Fill in the bundle ID once installed:
  #   mdls -name kMDItemCFBundleIdentifier -r "/Applications/FS-UAE.app"
  bundle_id = "net.fs-uae.FS-UAE"

  # Find all folder / files:
  #   sudo find ~/Library /Library /private/var/folders -iname "*net.fs-uae.FS-UAE*" 2>/dev/null
  zap trash: [
    "~/Library/Application Support/#{bundle_id}",
    "~/Library/Caches/#{bundle_id}",
    "~/Library/HTTPStorages/#{bundle_id}",
    "~/Library/Preferences/#{bundle_id}.plist",
    "~/Library/Saved Application State/#{bundle_id}.savedState",
  ]

end
