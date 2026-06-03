class TouchidCheck < Formula
  desc "macOS Touch ID approval helper for agent launch gates"
  homepage "https://github.com/nvk/bondage"
  url "https://github.com/nvk/bondage.git",
      tag:      "v0.2.7",
      revision: "50018ccca56fc4903b5698ec9afc3e7b807a3ad0"
  head "https://github.com/nvk/bondage.git", branch: "main"

  depends_on :macos

  def install
    system "make", "touchid-check"
    bin.install "touchid-check"
  end

  test do
    assert_match "Usage:", shell_output("#{bin}/touchid-check --help")
  end
end
