cask "katalog" do
  version "0.10.10,739"
  sha256 "4c393cb5bf882e5f2f63069befc4fe50165b02d823317a0dcbafab970d09425f"

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
  depends_on arch: [:arm64, :intel]
  depends_on macos: :sonoma

  # conflicts_with cask: ""

  app "Katalog.app"

  bundle_id = "com.musickatalog.katalog"

  zap trash: [
    "~/Library/Application Support/#{bundle_id}",
    "~/Library/Caches/#{bundle_id}",
    "~/Library/HTTPStorages/#{bundle_id}",
    "~/Library/Preferences/#{bundle_id}.plist",
    "~/Library/Saved Application State/#{bundle_id}.savedState",
  ]
end
