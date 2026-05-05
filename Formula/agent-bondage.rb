class AgentBondage < Formula
  desc "Trusted C launcher for local AI agent stacks"
  homepage "https://github.com/nvk/bondage"
  url "https://github.com/nvk/bondage.git",
      tag:      "v0.2.5",
      revision: "7b94f9ceceecd144a2ab59d9e6edf6ec02083ca2"
  version "0.2.5"
  head "https://github.com/nvk/bondage.git", branch: "main"

  def install
    system "make"
    bin.install "bondage"
  end

  test do
    assert_match "Usage:", shell_output("#{bin}/bondage 2>&1", 2)
    assert_match "sha256:", shell_output("#{bin}/bondage hash-file #{bin}/bondage")
  end
end
