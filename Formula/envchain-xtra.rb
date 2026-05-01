class EnvchainXtra < Formula
  desc "Keychain-backed environment launcher with macOS-focused fixes"
  homepage "https://github.com/nvk/envchain-xtra"
  url "https://github.com/nvk/envchain-xtra.git",
      tag:      "v1.3.1",
      revision: "b272204b5c13eb266f4cb9a3989cf5408a7c63f3"
  version "1.3.1"
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
