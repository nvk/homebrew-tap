class EnvchainXtra < Formula
  desc "Keychain-backed environment launcher with macOS-focused fixes"
  homepage "https://github.com/nvk/envchain-xtra"
  url "https://github.com/nvk/envchain-xtra.git",
      tag:      "v1.2.0",
      revision: "e894090048d23a0eadc8bdba8067a4814bdceec6"
  version "1.2.0"
  license "MIT"
  head "https://github.com/nvk/envchain-xtra.git", branch: "master"

  conflicts_with "envchain", because: "both install the envchain executable"

  on_linux do
    depends_on "pkgconf" => :build
    depends_on "libsecret"
    depends_on "readline"
  end

  def install
    system "make"
    bin.install "envchain"
  end

  test do
    output = shell_output("#{bin}/envchain --help 2>&1")
    assert_match "envchain", output
  end
end
