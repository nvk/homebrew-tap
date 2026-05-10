class AsciiBanner < Formula
  include Language::Python::Virtualenv

  desc "Convert text to ASCII art banners using 328 FIGlet fonts"
  homepage "https://github.com/nvk/ascii-banner"
  url "https://files.pythonhosted.org/packages/source/a/ascii-banner/ascii_banner-0.4.0.tar.gz"
  sha256 "af9a0cebeaddcddeacd05ddc470495ea765fc7040ba6ca8fbe05eb2930f9c9da"
  license "MIT"

  depends_on "python@3.12"

  def install
    virtualenv_install_with_resources
  end

  test do
    assert_match "___", shell_output("#{bin}/ascii-banner -f standard test")
  end
end
