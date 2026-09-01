class AgentBondage < Formula
  desc "Trusted C launcher for local AI agent stacks"
  homepage "https://github.com/nvk/bondage"
  url "https://github.com/nvk/bondage.git",
      tag:      "v0.2.8",
      revision: "9a8db25673338bc80b71262a69c9328e690fb2f3"
  version "0.2.8"
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
