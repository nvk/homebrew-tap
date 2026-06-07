class LlmHealth < Formula
  include Language::Python::Virtualenv

  desc "Local-first health intelligence CLI and agent plugin scaffold"
  homepage "https://llm-health.net"
  url "https://github.com/nvk/llm-health/releases/download/v0.0.7/llm_health-0.0.7.tar.gz"
  sha256 "5fbef2c45e748ccc36d2424d4ea7277ce829e77d18940839a02e1cdda776bf4d"
  license "MIT"

  depends_on "python@3.11"

  def install
    venv = virtualenv_create(libexec, "python3.11")
    system venv.root/"bin/python", "-m", "pip", "install", "--upgrade", "pip", "setuptools", "wheel"
    system venv.root/"bin/python", "-m", "pip", "install", ".[v2-core]"

    bin.install_symlink libexec/"bin/health"
    bin.install_symlink libexec/"bin/llm-health"
    bin.install_symlink libexec/"bin/health-v2"
  end

  def caveats
    <<~EOS
      Initialize your private llm-health HUB/store with:
        health agreement show
        health config hub-path ~/health --init --accept-risk
        health doctor

      Then import the latest de-identified health-assessment wiki rows with:
        health sync-v2 --wiki-root <health-assessments-topic-root> --profile all

      Agent plugin templates are available at:
        health plugin-paths

      This Homebrew formula installs the package-first CLI plus v2-core analytics.
      The full live Panel dashboard remains an optional Python extra for dev installs.
    EOS
  end

  test do
    assert_match "llm-health", shell_output("#{bin}/health doctor")
    assert_match "Health Assessment v2", shell_output("#{bin}/health-v2 doctor")
    hub = testpath/"health-hub"
    assert_match "Initialized", shell_output("#{bin}/health config hub-path #{hub} --init --accept-risk")
    assert_path_exists hub/"agreement.json"
    assert_path_exists hub/"manifest.json"
  end
end
