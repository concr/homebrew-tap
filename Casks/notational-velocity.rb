cask "notational-velocity" do

  version "2.5.2"
  sha256 "f84ebcef767ad6191850902b4576d6b8136e059ccc61b22874cf372c8b8e7f8b"

  url "https://github.com/scrod/nv/releases/download/v#{version}/NotationalVelocity-#{version}.zip"
  name "Notational Velocity"
  desc "Modeless, mouseless macOS note-taking application."
  homepage "https://github.com/scrod/nv"

  livecheck do
    url :url
    strategy :github_latest
  end

  # auto_updates true
  
  depends_on macos: :ventura  # notational-velocity runs from 11.5 big sur but 13.0 ventura is the lowest we can use
  app "Notational Velocity.app"

  bundle_id = "net.notational.velocity"

  zap trash: [
    "~/Library/Application Support/#{bundle_id}",
    "~/Library/Caches/#{bundle_id}",
    "~/Library/HTTPStorages/#{bundle_id}",
    "~/Library/Preferences/#{bundle_id}.plist",
    "~/Library/Saved Application State/#{bundle_id}.savedState",
  ]

end
