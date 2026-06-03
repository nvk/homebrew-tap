cask "qrme" do
  version "0.1.0"
  sha256 "018bd37858834cccabc4bc4c7aa48d1e6de5148321ee6a330ac81a75c64030e2"

  url "https://github.com/nvk/qrme/releases/download/v#{version}/QRMe.service.zip"
  name "QRMe"
  desc "Show selected text as a QR code from the Services menu"
  homepage "https://github.com/nvk/qrme"

  depends_on macos: :ventura

  service "QRMe.service"

  postflight do
    system_command "/System/Library/CoreServices/pbs",
                   args:         ["-update"],
                   must_succeed: false
  end

  uninstall_postflight do
    system_command "/System/Library/CoreServices/pbs",
                   args:         ["-update"],
                   must_succeed: false
  end
end
