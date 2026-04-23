class AsciiBanner < Formula
  include Language::Python::Virtualenv

  desc "Convert text to ASCII art banners using 328 FIGlet fonts"
  homepage "https://github.com/nvk/ascii-banner"
  url "https://files.pythonhosted.org/packages/source/a/ascii-banner/ascii_banner-0.3.1.tar.gz"
  sha256 "a5734fd56fd0bba4c6245f488063a936a2555c7baea7d2c05a6e92858e002427"
  license "MIT"

  depends_on "python@3.12"

  def install
    virtualenv_install_with_resources
  end

  test do
    assert_match "___", shell_output("#{bin}/ascii-banner -f standard test")
  end
end
