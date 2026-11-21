cask "katalog" do
  version "1.1.2,753"
  sha256 "0c2a6206c39cd6a46b6c4662eb9a34cc3fa7449d055eb6ad88d0d05035277dde"

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
