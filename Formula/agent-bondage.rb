class AgentBondage < Formula
  desc "Trusted C launcher for local AI agent stacks"
  homepage "https://github.com/nvk/bondage"
  url "https://github.com/nvk/bondage.git",
      tag:      "v0.2.4",
      revision: "908e0b7db9089b00d7be6386f12f46219ebd392e"
  version "0.2.4"
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
