class Socat < Formula
  desc "SOcket CAT: netcat on steroids"
  homepage "http://www.dest-unreach.org/socat/"
  url "http://www.dest-unreach.org/socat/download/socat-1.7.4.1.tar.gz"
  sha256 "0c7e635070af1b9037fd96869fc45eacf9845cb54547681de9d885044538736d"
  license "GPL-2.0"

  livecheck do
    url "http://www.dest-unreach.org/socat/download/"
    regex(/href=.*?socat[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    sha256 cellar: :any, arm64_big_sur: "1d355658a55eb44cb6ffe1fa8dc140883359467080e13be0d4237cf181c05dc0"
    sha256 cellar: :any, big_sur:       "2249d3b3852d95fc683e27292e26967b0e3a13d60e59a99181445f941a343a32"
    sha256 cellar: :any, catalina:      "f2a0d0d0bca542cb0f4b700d42dc244e82b8da9be2d5aff8d98b8a7fef77c9fe"
    sha256 cellar: :any, mojave:        "531f3ea55671c8d01165c3a314b24cef873c51442a1729fe2e9ce14ff908aebb"
    sha256 cellar: :any, x86_64_linux:  "b4e2763f4454ff3f3731e3b2df346a998065e8b04a7d03bc9a6e72ae1a0bf8cc" # linuxbrew-core
  end

  depends_on "openssl@1.1"
  depends_on "readline"

  def install
    system "./configure", "--prefix=#{prefix}", "--mandir=#{man}"
    system "make", "install"
  end

  test do
    output = pipe_output("#{bin}/socat - tcp:www.google.com:80", "GET / HTTP/1.0\r\n\r\n")
    assert_match "HTTP/1.0", output.lines.first
  end
end
