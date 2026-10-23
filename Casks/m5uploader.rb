cask "m5uploader" do

  version "1.1.2"
  sha256 "69d9e8c1689f0c450a3f800efd0024b7ca044f64dd5acafa347c81a4d3a6b1ba"

  url "https://github.com/cryptspeak/m5uploader/releases/download/v#{version}/m5uploader-macos.zip"
  name "m5uploader"
  desc "A minimal, security-conscious replacement for m5Burner."
  homepage "https://github.com/cryptspeak/m5uploader"

  livecheck do
    url :url
    strategy :github_latest
  end

  # m4uploader runs from 11.0 big sur but 13.0 ventura is the lowest we can use
  depends_on macos: :ventura
  app "m5uploader-macos.app", target: "m5uploader.app"

  binary "#{appdir}/M5Uploader.app/Contents/MacOS/m5uploader-macos", target: "m5uploader"

  caveats <<~EOS
    #{token} is not notarized by Apple. On first launch macOS will block it:
    open it once, then go to System Settings → Privacy & Security and click
    "Open Anyway". This is only needed once.

    Run the commmand m5uploader from terminal and then notarize it in settings.
  EOS

  # caveats do
  #   unsigned_accessibility 
  # end

end
