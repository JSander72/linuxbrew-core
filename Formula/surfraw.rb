class Surfraw < Formula
  desc "Shell Users' Revolutionary Front Rage Against the Web"
  homepage "https://packages.debian.org/sid/surfraw"
  url "https://ftp.openbsd.org/pub/OpenBSD/distfiles/surfraw-2.3.0.tar.gz"
  sha256 "ad0420583c8cdd84a31437e59536f8070f15ba4585598d82638b950e5c5c3625"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "65d1418f750b53be50f7d67e98791242056d4d7b5e21ba177899435fd9ac9d0f"
    sha256 cellar: :any_skip_relocation, big_sur:       "a9e126e0e78269271cee0952d6576fb99c443f49449dc9196a53ee2eb65d7ea6"
    sha256 cellar: :any_skip_relocation, catalina:      "2a2267217bfdd25ea00b3a08f76c44518e33dac0192a8590e4b3bfa3b5d90073"
    sha256 cellar: :any_skip_relocation, mojave:        "c9f5fc8020b021799c68cd204d4612f487c44315c15967be78a037576b378920"
    sha256 cellar: :any_skip_relocation, high_sierra:   "69920395cbde5fdc2492aa27fc765d4dafe910e26d9d3a05777888425310a0a9"
    sha256 cellar: :any_skip_relocation, sierra:        "69920395cbde5fdc2492aa27fc765d4dafe910e26d9d3a05777888425310a0a9"
    sha256 cellar: :any_skip_relocation, el_capitan:    "69920395cbde5fdc2492aa27fc765d4dafe910e26d9d3a05777888425310a0a9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "48b20736aae201046c9fdd3f0952ee5776be80c7eb0a7b68b3c75b837eca9285" # linuxbrew-core
  end

  def install
    system "./configure", "--prefix=#{prefix}",
                          "--sysconfdir=#{etc}",
                          "--with-graphical-browser=open"
    system "make"
    ENV.deparallelize
    system "make", "install"
  end

  test do
    output = shell_output("#{bin}/surfraw -p duckduckgo homebrew")
    assert_equal "https://duckduckgo.com/lite/?q=homebrew", output.chomp
  end
end
