class AgentBondage < Formula
  desc "Trusted C launcher for local AI agent stacks"
  homepage "https://github.com/nvk/bondage"
  url "https://github.com/nvk/bondage.git",
      tag:      "v0.1.0",
      revision: "1f82a6b44dca2b8934cbdb30ce16cc393e89b04b"
  version "0.1.0"
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
