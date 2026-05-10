class AsciiBanner < Formula
  include Language::Python::Virtualenv

  desc "Convert text to ASCII art banners using 328 FIGlet fonts"
  homepage "https://github.com/nvk/ascii-banner"
  url "https://files.pythonhosted.org/packages/ed/61/cc7730dd3a2e2191f4af2e41afc17a03030a9033d2bdba7a56e7b494d3cc/ascii_banner-0.4.1.tar.gz"
  sha256 "1e940e18e8492c6256e8688b56d0da5cd2e38ee2435786a6b201f6eb71a8bfbc"
  license "MIT"

  depends_on "python@3.12"

  def install
    virtualenv_install_with_resources
  end

  test do
    assert_match "___", shell_output("#{bin}/ascii-banner -f standard test")
  end
end
