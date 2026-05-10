class AsciiBanner < Formula
  include Language::Python::Virtualenv

  desc "Convert text to ASCII art banners using 328 FIGlet fonts"
  homepage "https://github.com/nvk/ascii-banner"
  url "https://files.pythonhosted.org/packages/eb/31/07d46660f145245784ba3b3605128e6896457082d34b31c9823e67ff4572/ascii_banner-0.5.0.tar.gz"
  sha256 "e5c6e2aa9516c6ee20c639c88e0b2ae9a77d13331c84a2f3f6abc043fb6503bd"
  license "MIT"

  depends_on "python@3.12"

  def install
    virtualenv_install_with_resources
  end

  test do
    assert_match "___", shell_output("#{bin}/ascii-banner -f standard test")
  end
end
