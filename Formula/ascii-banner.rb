class AsciiBanner < Formula
  include Language::Python::Virtualenv

  desc "Convert text to ASCII art banners using 328 FIGlet fonts"
  homepage "https://github.com/nvk/ascii-banner"
  url "https://files.pythonhosted.org/packages/ba/33/96e1551f3d78bf16278f9f9bccc6e2c6fc6cee04cb0411910efcf4c6edb4/ascii_banner-0.6.0.tar.gz"
  sha256 "829c26e80721051561c443da0c967836c9bd2e4ed78a571e928de4df5309c1e4"
  license "MIT"

  depends_on "python@3.12"

  def install
    virtualenv_install_with_resources
  end

  test do
    assert_match "___", shell_output("#{bin}/ascii-banner -f standard test")
  end
end
