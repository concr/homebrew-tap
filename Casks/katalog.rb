cask "katalog" do

  version "0.10.2,726"
  sha256 "5dfd47b0e7d8b391fe84697335b204f9279d68b71e58542f87d2d181098736a4"

  url "https://musickatalog.com/download/Katalog-#{version.csv.second}.dmg"
  name "Katalog"
  desc "Music library catalog app"
  homepage "https://musickatalog.com/"

  livecheck do
    url :homepage
    regex(/Version\s+v?(\d+(?:\.\d+)+).{1,60}?build\s+(\d+)/im)
    strategy :page_match do |page, regex|
      page.scan(regex).map { |match| "#{match[0]},#{match[1]}" }
    end
  end

  auto_updates true

  depends_on macos: :sonoma
  app "Katalog.app"

  # Fill in the bundle ID once installed:
  #   mdls -name kMDItemCFBundleIdentifier -r "/Applications/Katalog.app"
  bundle_id = "com.musickatalog.katalog"

  # Find all folder / files:
  #   sudo find ~/Library /Library /private/var/folders -iname "*com.musickatalog.katalog*" 2>/dev/null
  zap trash: [
    "~/Library/Application Support/#{bundle_id}",
    "~/Library/Caches/#{bundle_id}",
    "~/Library/HTTPStorages/#{bundle_id}",
    "~/Library/Preferences/#{bundle_id}.plist",
    "~/Library/Saved Application State/#{bundle_id}.savedState",
  ]
end
