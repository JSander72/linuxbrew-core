class HttpLoad < Formula
  desc "Test throughput of a web server by running parallel fetches"
  homepage "https://www.acme.com/software/http_load/"
  url "https://www.acme.com/software/http_load/http_load-09Mar2016.tar.gz"
  version "20160309"
  sha256 "5a7b00688680e3fca8726dc836fd3f94f403fde831c71d73d9a1537f215b4587"
  revision 2

  livecheck do
    url :homepage
    regex(/href=.*?http_load[._-]v?(\d+[a-z]+\d+)\.t/i)
    strategy :page_match do |page, regex|
      # Convert date-based version from 09Mar2016 format to 20160309
      page.scan(regex).map do |match|
        date_str = match&.first
        date_str ? Date.parse(date_str)&.strftime("%Y%m%d") : nil
      end
    end
  end

  bottle do
    sha256 cellar: :any, arm64_big_sur: "d5fc5ba0ce6baf991e45fcb70f6e2fd3153e1f902d1d510cf015b3ff8cc4d0c3"
    sha256 cellar: :any, big_sur:       "67456aed34ccc1d9873b946ed2adb7c86ecd52ad90a495f9527afd0a883710d0"
    sha256 cellar: :any, catalina:      "36fada1e1b8cbe35a9eb1fb2374c175a003d750f0560565c6bfaf6b90a17f748"
    sha256 cellar: :any, mojave:        "d0d672723564b758fc3ef0721239e108ec063a395e183db033071200d5d9ee48"
    sha256 cellar: :any, high_sierra:   "22e21275c49121c174024104f9b99c5f55d37e032ff7cae42bba89746c26bd88"
    sha256 cellar: :any, sierra:        "a949ed2040faf49c7cdb6bf0110dfbbff465641c811e78a035998a4160170a05"
    sha256 cellar: :any, x86_64_linux:  "30aacd4e7c9db8332f96f490a653b0955aaeaddfe35fcde7aa1218187c044803" # linuxbrew-core
  end

  depends_on "openssl@1.1"

  def install
    bin.mkpath
    man1.mkpath

    args = %W[
      BINDIR=#{bin}
      LIBDIR=#{lib}
      MANDIR=#{man1}
      CC=#{ENV.cc}
      SSL_TREE=#{Formula["openssl@1.1"].opt_prefix}
    ]

    inreplace "Makefile", "#SSL_", "SSL_"
    system "make", "install", *args
  end

  test do
    (testpath/"urls").write "https://brew.sh/"
    system "#{bin}/http_load", "-rate", "1", "-fetches", "1", "urls"
  end
end
