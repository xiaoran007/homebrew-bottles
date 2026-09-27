class Mpfr < Formula
  desc "C library for multiple-precision floating-point computations"
  homepage "https://www.mpfr.org/"
  url "https://ftpmirror.gnu.org/mpfr/mpfr-4.2.2.tar.xz"
  mirror "https://ftp.gnu.org/gnu/mpfr/mpfr-4.2.2.tar.xz"
  sha256 "b67ba0383ef7e8a8563734e2e889ef5ec3c3b898a01d00fa0a6869ad81c6ce01"
  license "LGPL-3.0-or-later"
  compatibility_version 1
  head "https://gitlab.inria.fr/mpfr/mpfr.git", branch: "master"

  livecheck do
    url "https://www.mpfr.org/mpfr-current/"
    regex(/href=.*?mpfr[._-]v?(\d+(?:\.\d+)+)\.t/i)
    strategy :page_match do |page, regex|
      version = page.scan(regex).map { |match| Version.new(match[0]) }.max&.to_s
      next if version.blank?

      patch = page.scan(%r{href=["']?/?patch(\d+)["' >]}i)
                  .map { |match| Version.new(match[0]) }
                  .max
                  &.to_s
      next version if patch.blank?

      "#{version}-p#{patch.to_i}"
    end
  end

  

  depends_on "xiaoran007/bottles/autoconf" => :build
  depends_on "xiaoran007/bottles/automake" => :build
  depends_on "xiaoran007/bottles/libtool" => :build
  depends_on "xiaoran007/bottles/gmp"

  on_system :linux, macos: :ventura_or_newer do
    depends_on "texinfo" => :build
  end

  def install
    system "./autogen.sh" if build.head?

    system "./configure", "--disable-silent-rules", *std_configure_args
    system "make"
    system "make", "check"
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~C
      #include <mpfr.h>
      #include <math.h>
      #include <stdlib.h>
      #include <string.h>

      int main() {
        mpfr_t x, y;
        mpfr_inits2 (256, x, y, NULL);
        mpfr_set_ui (x, 2, MPFR_RNDN);
        mpfr_rootn_ui (y, x, 2, MPFR_RNDN);
        mpfr_pow_si (x, y, 4, MPFR_RNDN);
        mpfr_add_si (y, x, -4, MPFR_RNDN);
        mpfr_abs (y, y, MPFR_RNDN);
        if (fabs(mpfr_get_d (y, MPFR_RNDN)) > 1.e-30) abort();
        if (strcmp("#{version}", mpfr_get_version())) abort();
        return 0;
      }
    C
    system ENV.cc, "test.c", "-L#{lib}", "-L#{formula_opt_lib("gmp")}",
                   "-lgmp", "-lmpfr", "-o", "test"
    system "./test"
  end

  bottle do
    root_url "https://ghcr.io/v2/xiaoran007/bottles"
    sha256 cellar: :any, arm64_sonoma: "acc55b777f86daed3a6aeb61a4fa39df7c36a10b3bd0bad20672a188f4a51f7f"
  end
end
