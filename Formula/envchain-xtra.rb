class EnvchainXtra < Formula
  desc "Keychain-backed environment launcher with macOS-focused fixes"
  homepage "https://github.com/nvk/envchain-xtra"
  url "https://github.com/nvk/envchain-xtra.git",
      tag:      "v1.4.1",
      revision: "4ea98043752c386a87f572347f471c33f7dcb8a1"
  version "1.4.1"
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
