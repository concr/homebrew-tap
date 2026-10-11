cask "dmde@beta" do

  version "4.5.0,849"

  # Fill in: curl -sL https://dmde.com/download/dmde-4-5-0-849-beta-mac64-gui.dmg | shasum -a 256
  sha256 "ce26f4bda9e377740e6624139d5e7b24a188b5cfd125dc4888b3d63bdcf26961"

  url "https://dmde.com/download/dmde-#{version.csv.first.dots_to_hyphens}-#{version.csv.second}-beta-mac64-gui.dmg"
  name "DMDE"
  desc "Powerful Data Recovery Software."
  homepage "https://dmde.com"

  livecheck do
    url "https://dmde.com/download.html"
    regex(/href=["']?[^"' >]*?dmde[._-]v?(\d+(?:-\d+)+)-(\d+)-mac64-gui\.dmg/i)
    strategy :page_match do |page, regex|
      page.scan(regex).map { |match| "#{match[0].tr("-", ".")},#{match[1]}" }
    end
  end

  # dmde runs from 10.14 mojave but 13.0 ventura is the lowest we can use
  depends_on macos: :ventura
  app "dmde.app"
  conflicts_with cask: "dmde"

  # Fill in the bundle ID once installed:
  #   mdls -name kMDItemCFBundleIdentifier -r "/Applications/dmde.app"
  bundle_id = "com.dmde.DMDE"

  # Find all folder / files:
  #   sudo find ~/Library /Library /private/var/folders -iname "*com.dmde.DMDE*" 2>/dev/null
  zap trash: [
    "~/Library/Application Support/#{bundle_id}",
    "~/Library/Caches/#{bundle_id}",
    "~/Library/HTTPStorages/#{bundle_id}",
    "~/Library/Preferences/#{bundle_id}.plist",
    "~/Library/Saved Application State/#{bundle_id}.savedState",
  ]

end
