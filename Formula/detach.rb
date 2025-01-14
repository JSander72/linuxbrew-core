class Detach < Formula
  desc "Execute given command in detached process"
  homepage "http://inglorion.net/software/detach/"
  url "http://inglorion.net/download/detach-0.2.3.tar.bz2"
  sha256 "b2070e708d4fe3a84197e2a68f25e477dba3c2d8b1f9ce568f70fc8b8e8a30f0"
  license "MIT"

  livecheck do
    url :homepage
    regex(/href=.*?detach[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "934338f4dbae7773162dfa2a6b83d3c72a0740747bd4494509a9d5ee20bf37b5"
    sha256 cellar: :any_skip_relocation, big_sur:       "9db6ee661710f178b17fc1096596ee74b07b257e233da7fb45cb9280cbeb24a1"
    sha256 cellar: :any_skip_relocation, catalina:      "dbd06a1dcb4592035dff0b4df0cc3259c2dbb444acdb1553ab2a2d4edf3fff57"
    sha256 cellar: :any_skip_relocation, mojave:        "4aa3f65488ee7fb05d156d92f5f76a29d2cebe2034b226665e219978e228f1db"
    sha256 cellar: :any_skip_relocation, high_sierra:   "3367f32cb05a37e05e9ab18e4e1f2664137f7d03073fc2d9ec4aba0d62a6f431"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8c8d040524edff3ad1d757eb94e4784296d88a6e6f8ae76c66da7fd87987b0ee" # linuxbrew-core
  end

  def install
    system "make", "install", "PREFIX=#{prefix}"
    bin.install "detach"
    man1.install "detach.1"
  end

  test do
    system "#{bin}/detach", "-p", "#{testpath}/pid", "sh", "-c", "sleep 10"
    pid = (testpath/"pid").read.to_i
    ppid = shell_output("ps -p #{pid} -o ppid=").to_i
    assert_equal 1, ppid
    Process.kill "TERM", pid
  end
end
