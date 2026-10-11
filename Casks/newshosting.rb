cask "newshosting" do

  version "3.8.9"

  sha256 :no_check

  url "https://client-index.newshosting.com/nh/latest/newshosting.dmg"
  name "Newshosting"
  desc "Usenet newsreader and downloader client."
  homepage "https://www.newshosting.com/"

  livecheck do
    url "https://client-index.newshosting.com/nh/"
    regex(/Version\s+v?(\d+(?:\.\d+)+)/i)
  end

  # dmde runs from 10.13 mojave but 13.0 ventura is the lowest we can use
  depends_on macos: :ventura
  app "Newshosting.app"

  # Fill in after first install:
  #   mdls -name kMDItemCFBundleIdentifier -r /Applications/Newshosting.app
  # bundle_id = "…"
  # zap trash: [
  #   "~/Library/Application Support/Newshosting",
  #   "~/Library/Preferences/#{bundle_id}.plist",
  # ]
end
