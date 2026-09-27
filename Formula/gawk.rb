class Gawk < Formula
  desc "GNU awk utility"
  homepage "https://www.gnu.org/software/gawk/"
  url "https://ftpmirror.gnu.org/gawk/gawk-5.4.1.tar.xz"
  mirror "https://ftp.gnu.org/gnu/gawk/gawk-5.4.1.tar.xz"
  sha256 "07f6f7342b7febe4313fc2c2542ad93d64fe20ad8717200109f105a826f5fd37"
  license "GPL-3.0-or-later"
  compatibility_version 1
  head "https://git.savannah.gnu.org/git/gawk.git", branch: "master"

  

  depends_on "xiaoran007/bottles/gmp"
  depends_on "xiaoran007/bottles/mpfr"
  depends_on "xiaoran007/bottles/readline"

  on_macos do
    depends_on "xiaoran007/bottles/gettext"
  end

  on_linux do
    conflicts_with "awk", because: "both install an `awk` executable"
  end

  def install
    system "./bootstrap.sh" if build.head?

    # case-check needs libc to fold ẞ (U+1E9E) to ß, which Sonoma lacks
    if OS.mac? && MacOS.version <= :sonoma
      inreplace "test/Makefile.in", "callparam case-check childin", "callparam childin"
    end

    args = %w[
      --disable-silent-rules
      --without-libsigsegv-prefix
    ]
    system "./configure", *args, *std_configure_args

    system "make"
    if which "cmp"
      # Cannot run pma tests in Docker container due to seccomp needed for personality syscall
      check_args = ["NEED_PMA="] if OS.linux?
      system "make", "check", *check_args
    else
      opoo "Skipping `make check` due to unavailable `cmp`"
    end
    system "make", "install"

    (bin/"awk").unlink if OS.mac?
    (libexec/"gnubin").install_symlink bin/"gawk" => "awk"
    (libexec/"gnuman/man1").install_symlink man1/"gawk.1" => "awk.1"
    (libexec/"gnubin").install_symlink "../gnuman" => "man"
  end

  def caveats
    on_macos do
      <<~EOS
        GNU "awk" has been installed as "gawk".
        If you need to use it as "awk", you can add a "gnubin" directory
        to your PATH from your ~/.bashrc and/or ~/.zshrc like:

            PATH="#{opt_libexec}/gnubin:$PATH"
      EOS
    end
  end

  test do
    output = pipe_output("#{bin}/gawk '{ gsub(/Macro/, \"Home\"); print }' -", "Macrobrew")
    assert_equal "Homebrew", output.strip
  end

  bottle do
    root_url "https://ghcr.io/v2/xiaoran007/bottles"
    sha256 cellar: "/opt/homebrew/Cellar", arm64_sonoma: "ef26b1f7da12a89f23dc7c92cd06082932e7d291774bac52d876d54845506330"
  end
end
