class LibcouchbaseAT2 < Formula
  desc "C library for Couchbase"
  homepage "https://docs.couchbase.com/c-sdk/2.10/start-using-sdk.html"
  url "https://packages.couchbase.com/clients/c/libcouchbase-2.10.9.tar.gz"
  sha256 "6f6450121e0208005c17f7f4cdd9258a571bb22183f0bc08f11d75c207d55d0a"
  license "Apache-2.0"

  bottle do
    sha256                               arm64_big_sur: "5e0bb389630242e3db72c20cb884c501ddb0886f379adcb55b7db0b889e692f6"
    sha256                               big_sur:       "9ccf1d8d54a3b9bad9da0b4fef45da6320060f4675cc9c1e75a7dea605003ad2"
    sha256                               catalina:      "01b9bceacbd38205745952c98a7db51cc388049da2a950d26eab11ab4b8dee64"
    sha256                               mojave:        "fddb24ff1b03d1dbf91f2ac46096ebd113e5dde208e49430ac55de783fa9f897"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "59ccfded2657c0fb08783be2e6e94bbb78bc7ebf9543d342f1e6970234d7f293" # linuxbrew-core
  end

  keg_only :versioned_formula

  depends_on "cmake" => :build
  depends_on "libev"
  depends_on "libevent"
  depends_on "libuv"
  depends_on "openssl@1.1"

  def install
    mkdir "build" do
      system "cmake", "..", *std_cmake_args,
                            "-DLCB_NO_TESTS=1",
                            "-DLCB_BUILD_LIBEVENT=ON",
                            "-DLCB_BUILD_LIBEV=ON",
                            "-DLCB_BUILD_LIBUV=ON"
      system "make", "install"
    end
  end

  test do
    assert_match "LCB_ECONNREFUSED",
      shell_output("#{bin}/cbc cat document_id -U couchbase://localhost:1 2>&1", 1).strip
  end
end
