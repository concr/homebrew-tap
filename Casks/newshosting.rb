cask "newshosting" do

  version "3.8.9"
  sha256 :no_check

  url "https://client-index.newshosting.com/nh/latest/newshosting.dmg"
  name "Newshosting"
  desc "Usenet newsreader and downloader client."
  homepage "https://client-index.newshosting.com/nh/"

  livecheck do
    url :homepage
    regex(/Version\s+v?(\d+(?:\.\d+)+)/i)
  end

  # auto_updates true
  
  depends_on macos: :ventura  # newshosting runs from 10.13 mojave but 13.0 ventura is the lowest we can use
  # conflicts_with cask: ""

  app "Newshosting.app"
  bundle_id = "com.newshosting.client"

  zap trash: [
    "~/Library/Application Support/#{bundle_id}",
    "~/Library/Caches/#{bundle_id}",
    "~/Library/HTTPStorages/#{bundle_id}",
    "~/Library/Preferences/#{bundle_id}.plist",
    "~/Library/Saved Application State/#{bundle_id}.savedState",
  ]

end
