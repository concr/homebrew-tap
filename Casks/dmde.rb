cask "dmde" do

  version "4.4.6,846"
  sha256 "ce26f4bda9e377740e6624139d5e7b24a188b5cfd125dc4888b3d63bdcf26961"

  url "https://dmde.com/download/dmde-#{version.csv.first.dots_to_hyphens}-#{version.csv.second}-mac64-gui.dmg"
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

  # auto_updates true
  
  depends_on macos: :ventura  # dmde runs from 10.14 mojave but 13.0 ventura is the lowest we can use
  conflicts_with cask: "dmde@beta"

  app "dmde.app", target: "DMDE.app"
  bundle_id = "com.dmde.DMDE"

  zap trash: [
    "~/Library/Application Support/#{bundle_id}",
    "~/Library/Caches/#{bundle_id}",
    "~/Library/HTTPStorages/#{bundle_id}",
    "~/Library/Preferences/#{bundle_id}.plist",
    "~/Library/Saved Application State/#{bundle_id}.savedState",
  ]

end
