class Jq < Formula
  desc "Lightweight and flexible command-line JSON processor"
  homepage "https://jqlang.github.io/jq/"
  url "https://github.com/jqlang/jq/releases/download/jq-1.8.2/jq-1.8.2.tar.gz"
  sha256 "71b8d6e8f5fe81f6c6d0d110e3892251f6ce76ed095abd315e26e6e1193af3af"
  license "MIT"
  compatibility_version 1

  livecheck do
    url :stable
    regex(/^(?:jq[._-])?v?(\d+(?:\.\d+)+)$/i)
  end

  

  head do
    url "https://github.com/jqlang/jq.git", branch: "master"

    depends_on "xiaoran007/bottles/autoconf" => :build
    depends_on "xiaoran007/bottles/automake" => :build
    depends_on "xiaoran007/bottles/libtool" => :build
  end

  depends_on "xiaoran007/bottles/oniguruma"

  deny_network_access!

  def install
    system "autoreconf", "--force", "--install", "--verbose" if build.head?
    system "./configure", *std_configure_args,
                          "--disable-silent-rules",
                          "--disable-maintainer-mode"
    system "make", "install"
  end

  test do
    assert_equal "2\n", pipe_output("#{bin}/jq .bar", '{"foo":1, "bar":2}')
  end

  bottle do
    root_url "https://ghcr.io/v2/xiaoran007/bottles"
    sha256 cellar: :any, arm64_sonoma: "4563e54e09f94a3dbdad1535664841ff57d808ae225864c7b68ff0425c7ad20a"
  end
end
