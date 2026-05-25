class AgentnoiseDarkmatter < Formula
  desc "Experimental Dark Matter/Marmot v2 build of agentnoise"
  homepage "https://agentnoise.org"
  url "https://github.com/nvk/agentnoise/releases/download/darkmatter-v0.2.0-alpha.1/agentnoise-darkmatter-0.2.0-alpha.1-aarch64-apple-darwin.tar.gz"
  sha256 "d4d1f06d80f85593e748fdb3eba4f8702e646a9a2b7860d18839079ab4bda915"
  license "MIT"

  depends_on arch: :arm64
  depends_on :macos

  def install
    libexec.install "agentnoise"
    prefix.install "LICENSE", "README.md"

    (bin/"agentnoise-dm").write <<~SH
      #!/bin/bash
      exec "#{libexec}/agentnoise" --instance darkmatter "$@"
    SH
  end

  service do
    run [opt_bin/"agentnoise-dm", "up"]
    environment_variables PATH: "#{HOMEBREW_PREFIX}/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
    keep_alive true
    log_path var/"log/agentnoise-darkmatter.log"
    error_log_path var/"log/agentnoise-darkmatter.err.log"
  end

  def caveats
    <<~EOS
      Experimental Dark Matter/Marmot v2 alpha.

      This installs as:
        agentnoise-dm

      agentnoise-dm always runs:
        agentnoise --instance darkmatter ...

      That keeps it isolated from stable agentnoise:
        separate config/data/logs/keychain namespace
        separate Homebrew service label
        separate phone pairing

      Quick start with raw Codex/Claude:
        agentnoise-dm up --direct-agents

      Start at login for testing:
        brew services start nvk/tap/agentnoise-darkmatter

      Inspect the isolated config:
        agentnoise-dm config path
        agentnoise-dm status
        agentnoise-dm doctor

      Do not use this on a main paired identity unless you are explicitly
      testing the Dark Matter migration.
    EOS
  end

  test do
    assert_match "agentnoise 0.2.0", shell_output("#{bin}/agentnoise-dm --version")
    assert_match "darkmatter", shell_output("#{bin}/agentnoise-dm config path")
  end
end
