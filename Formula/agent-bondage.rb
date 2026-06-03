class AgentBondage < Formula
  desc "Trusted C launcher for local AI agent stacks"
  homepage "https://github.com/nvk/bondage"
  url "https://github.com/nvk/bondage.git",
      tag:      "v0.2.7",
      revision: "50018ccc275db1ef1f4e06f0353ef46fee13d464"
  head "https://github.com/nvk/bondage.git", branch: "main"

  def install
    system "make", "bondage"
    bin.install "bondage"
  end

  test do
    assert_match "Usage:", shell_output("#{bin}/bondage 2>&1", 2)
    assert_match "sha256:", shell_output("#{bin}/bondage hash-file #{bin}/bondage")
  end
end
