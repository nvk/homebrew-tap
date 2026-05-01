class EnvchainXtra < Formula
  desc "Keychain-backed environment launcher with macOS-focused fixes"
  homepage "https://github.com/nvk/envchain-xtra"
  url "https://github.com/nvk/envchain-xtra.git",
      tag:      "v1.3.0",
      revision: "c3db5fc5c2020a462e4824cda7e91db2bb6d23e2"
  version "1.3.0"
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
