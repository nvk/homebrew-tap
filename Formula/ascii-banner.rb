class AsciiBanner < Formula
  include Language::Python::Virtualenv

  desc "Convert text to ASCII art banners using 328 FIGlet fonts"
  homepage "https://github.com/nvk/ascii-banner"
  url "https://files.pythonhosted.org/packages/source/a/ascii-banner/ascii_banner-0.3.0.tar.gz"
  sha256 "5518f6d70c85d89634ae6d3d3e0e3a6cba4376f709fef9485a1d9ccb246a6607"
  license "MIT"

  depends_on "python@3.12"

  def install
    virtualenv_install_with_resources
  end

  test do
    assert_match "___", shell_output("#{bin}/ascii-banner -f standard test")
  end
end
