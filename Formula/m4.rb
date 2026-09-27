class M4 < Formula
  desc "Macro processing language"
  homepage "https://www.gnu.org/software/m4/"
  url "https://ftpmirror.gnu.org/m4/m4-1.4.21.tar.xz"
  mirror "https://ftp.gnu.org/gnu/m4/m4-1.4.21.tar.xz"
  mirror "http://ftp.gnu.org/gnu/m4/m4-1.4.21.tar.xz"
  sha256 "f25c6ab51548a73a75558742fb031e0625d6485fe5f9155949d6486a2408ab66"
  license "GPL-3.0-or-later"
  compatibility_version 1

  

  keg_only :provided_by_macos

  def install
    system "./configure", "--disable-dependency-tracking", "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end

  test do
    assert_match "Homebrew",
      pipe_output(bin/"m4", "define(TEST, Homebrew)\nTEST\n")
  end

  bottle do
    root_url "https://ghcr.io/v2/xiaoran007/bottles"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "b68aee53fe2ad23221ae5402d369ec6fb3fd11cee48ecbbca5ceb81a85d12458"
  end
end
