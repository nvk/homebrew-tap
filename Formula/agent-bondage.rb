class AgentBondage < Formula
  desc "Trusted C launcher for local AI agent stacks"
  homepage "https://github.com/nvk/bondage"
  url "https://github.com/nvk/bondage.git",
      tag:      "v0.3.1",
      revision: "ee7636333a7ea2fc510f6b935e830d97f2bc72e9"
  version "0.3.1"
  head "https://github.com/nvk/bondage.git", branch: "main"

  def install
    system "make", "bondage"
    bin.install "bondage"
  end

  test do
    assert_equal "bondage 0.3.1", shell_output("#{bin}/bondage --version").strip
    assert_match "Usage:", shell_output("#{bin}/bondage 2>&1", 2)
    assert_match "sha256:", shell_output("#{bin}/bondage hash-file #{bin}/bondage")
  end
end
