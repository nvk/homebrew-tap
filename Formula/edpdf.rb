class Edpdf < Formula
  include Language::Python::Virtualenv

  desc "Edit PDFs with native macOS selectors and terminal prompts"
  homepage "https://github.com/nvk/edpdf"
  url "https://github.com/nvk/edpdf/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "30b38d9a5f6cc32bec07dc3ff9ff2e52103760f98ee171d189fb3db19c78b48c"
  license "MIT"
  head "https://github.com/nvk/edpdf.git", branch: "main"

  depends_on :macos
  depends_on "python@3.13"
  depends_on "qpdf"

  def install
    virtualenv_install_with_resources
  end

  test do
    assert_match "edpdf 0.1.0", shell_output("#{bin}/edpdf --version")
  end
end

