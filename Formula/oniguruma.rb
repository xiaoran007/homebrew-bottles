class Oniguruma < Formula
  desc "Regular expressions library"
  homepage "https://github.com/kkos/oniguruma/"
  url "https://github.com/kkos/oniguruma/releases/download/v6.9.10/onig-6.9.10.tar.gz"
  sha256 "2a5cfc5ae259e4e97f86b68dfffc152cdaffe94e2060b770cb827238d769fc05"
  license "BSD-2-Clause"
  head "https://github.com/kkos/oniguruma.git", branch: "master"

  livecheck do
    skip "No longer developed or maintained"
  end

  

  depends_on "xiaoran007/bottles/autoconf" => :build
  depends_on "xiaoran007/bottles/automake" => :build
  depends_on "xiaoran007/bottles/libtool" => :build

  def install
    system "autoreconf", "--force", "--install", "--verbose"
    system "./configure", "--disable-dependency-tracking", "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end

  test do
    assert_match(/#{prefix}/, shell_output("#{bin}/onig-config --prefix"))
  end

  bottle do
    root_url "https://ghcr.io/v2/xiaoran007/bottles"
    sha256 cellar: :any, arm64_sonoma: "6084212c62f132689bf6c5939038ddc66167a429842a83c2ddce71f6d397187d"
  end
end
