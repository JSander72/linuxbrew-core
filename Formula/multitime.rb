class Multitime < Formula
  desc "Time command execution over multiple executions"
  homepage "https://tratt.net/laurie/src/multitime/"
  url "https://github.com/ltratt/multitime/archive/multitime-1.4.tar.gz"
  sha256 "31597066239896ee74a3aaaea3b22931a50a1ec1470090c5457ef35500c44249"
  license "MIT"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "52335b15831a687d6b1bf9ef67de299b3295143181ea0d9511b437a69362b385"
    sha256 cellar: :any_skip_relocation, big_sur:       "c744099831fd19d36e44e055b880803715fe570b7fd8b7879054ed83706b2625"
    sha256 cellar: :any_skip_relocation, catalina:      "ae01126fe74b8bb90f45b901a5e92665e6b392a5dad3af356313dae5835f70da"
    sha256 cellar: :any_skip_relocation, mojave:        "8d570dbc59cd06a441633d77bc126f0000c3b96a4b11abd48233b95ba403ab7d"
  end

  depends_on "autoconf" => :build

  def install
    system "autoconf"
    system "autoheader"

    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--mandir=#{man}"

    system "make", "install"
  end

  test do
    output = shell_output("#{bin}/multitime -n 2 sleep 1 2>&1")
    assert_match(/((real|user|sys)\s+([01].\d{3}\s*){5}){3}/m, output)
  end
end
