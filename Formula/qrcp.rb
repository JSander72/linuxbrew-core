class Qrcp < Formula
  desc "Transfer files to and from your computer by scanning a QR code"
  homepage "https://claudiodangelis.com/qrcp"
  url "https://github.com/claudiodangelis/qrcp/archive/0.8.4.tar.gz"
  sha256 "b77673bad880c9ffec1fa20cef6e46ae717702edd95bca3076919225e396db57"
  license "MIT"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "8286ab8384850578862e84cceebb7aa8efc5d2bafd1d372a0e9e1f6930a7a726"
    sha256 cellar: :any_skip_relocation, big_sur:       "b90c0f156ce21a2ec39f23405fd1213008d96a8e1d62f17cd0d5c83c17b055ea"
    sha256 cellar: :any_skip_relocation, catalina:      "954c095b0cd034464bd929a3b28855f932d09e0cb59a741939009221f6fdac94"
    sha256 cellar: :any_skip_relocation, mojave:        "a319771dea04ac593d2928e8e937ce1fd5a7c55c67999e9505b258cbddbe226c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "fc58219b4fb5fe5686cbd15810f20bcce6291916fd8ad451f17cbe340e22df4f" # linuxbrew-core
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args
  end

  test do
    (testpath/"test_data.txt").write <<~EOS
      Hello there, big world
    EOS

    port = free_port
    server_url = "http://localhost:#{port}/send/testing"

    (testpath/"config.json").write <<~EOS
      {
        "interface": "any",
        "fqdn": "localhost",
        "port": #{port}
      }
    EOS

    fork do
      exec bin/"qrcp", "-c", testpath/"config.json", "--path", "testing", testpath/"test_data.txt"
    end
    sleep 1

    # User-Agent header needed in order for curl to be able to receive file
    assert_equal shell_output("curl -H \"User-Agent: Mozilla\" #{server_url}"), "Hello there, big world\n"
  end
end
