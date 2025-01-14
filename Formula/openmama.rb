class Openmama < Formula
  desc "Open source high performance messaging API for various Market Data sources"
  homepage "https://openmama.finos.org"
  url "https://github.com/finos/OpenMAMA/archive/OpenMAMA-6.3.1-release.tar.gz"
  sha256 "43e55db00290bc6296358c72e97250561ed4a4bb3961c1474f0876b81ecb6cf9"
  license "LGPL-2.1-only"

  bottle do
    rebuild 1
    sha256 cellar: :any, arm64_big_sur: "e68c9fee04206d5f5b21d84889bf645c7f4b2b2922a886e9bbcc226a05faa183"
    sha256 cellar: :any, big_sur:       "b3d28de466d5f2d17ddb57b2f5004e3defc7f8d48922814f61f733aa7015639c"
    sha256 cellar: :any, catalina:      "50fe6f8436bd5d7729f9f20c21de8d398e50546754514708e24715a097bd21f1"
    sha256 cellar: :any, mojave:        "b0a5d95139fce5f6f72b5a2906c5e2e6b604aef25e2b76e7c448ab1bfcefe6d6"
  end

  depends_on "cmake" => :build
  depends_on "apr"
  depends_on "apr-util"
  depends_on "libevent"
  depends_on "ossp-uuid"
  depends_on "qpid-proton"

  uses_from_macos "flex" => :build

  def install
    mkdir "build" do
      system "cmake", "..", "-DAPR_ROOT=#{Formula["apr"].opt_prefix}",
                            "-DPROTON_ROOT=#{Formula["qpid-proton"].opt_prefix}",
                            "-DCMAKE_INSTALL_RPATH=#{rpath}",
                            "-DINSTALL_RUNTIME_DEPENDENCIES=OFF",
                            "-DWITH_TESTTOOLS=OFF",
                            *std_cmake_args
      system "make", "install"
    end
  end

  test do
    system "#{bin}/mamalistenc", "-?"
    (testpath/"test.c").write <<~EOS
      #include <mama/mama.h>
      #include <stdio.h>
      int main() {
          mamaBridge bridge;
          fclose(stderr);
          mama_status status = mama_loadBridge(&bridge, "qpid");
          if (status != MAMA_STATUS_OK) return 1;
          const char* version = mama_getVersion(bridge);
          if (NULL == version) return 2;
          printf("%s\\n", version);
          return 0;
      }
    EOS
    system ENV.cc, "test.c", "-I#{include}", "-L#{lib}", "-lmama", "-o", "test"
    assert_includes shell_output("./test"), version.to_s
  end
end
