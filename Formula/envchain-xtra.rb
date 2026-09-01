class EnvchainXtra < Formula
  desc "Keychain-backed environment launcher with macOS-focused fixes"
  homepage "https://github.com/nvk/envchain-xtra"
  url "https://github.com/nvk/envchain-xtra.git",
      tag:      "v1.4.0",
      revision: "9e654fb43f79380afc6f785c2730440ab5b99fc8"
  version "1.4.0"
  license "MIT"
  head "https://github.com/nvk/envchain-xtra.git", branch: "master"

  on_linux do
    depends_on "pkgconf" => :build
    depends_on "libsecret"
    depends_on "readline"
  end

  conflicts_with "envchain", because: "both install the envchain executable"

  def install
    system "make"
    bin.install "envchain"
  end

  test do
    output = shell_output("#{bin}/envchain --help 2>&1")
    assert_match "envchain", output
  end
end
