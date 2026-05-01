class AgentBondage < Formula
  desc "Trusted C launcher for local AI agent stacks"
  homepage "https://github.com/nvk/bondage"
  url "https://github.com/nvk/bondage.git",
      tag:      "v0.2.2",
      revision: "e6b8fc54b155ba01c177445c723acc41ac3b51f0"
  version "0.2.2"
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
