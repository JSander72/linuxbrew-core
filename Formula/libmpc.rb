class Libmpc < Formula
  desc "C library for the arithmetic of high precision complex numbers"
  homepage "http://www.multiprecision.org/mpc/"
  url "https://ftp.gnu.org/gnu/mpc/mpc-1.2.1.tar.gz"
  mirror "https://ftpmirror.gnu.org/mpc/mpc-1.2.1.tar.gz"
  sha256 "17503d2c395dfcf106b622dc142683c1199431d095367c6aacba6eec30340459"
  license "LGPL-3.0-or-later"

  bottle do
    sha256 cellar: :any, arm64_big_sur: "6a93bd78c1b55f8b29e11fd1e9c68c6c305ffe74aa5b978ba93189b6d84d1451"
    sha256 cellar: :any, big_sur:       "754667644cc287cd9691fd3215df260aa971562b5a7b6ca65e29b2e15ea1e656"
    sha256 cellar: :any, catalina:      "8c037df4b551058d00351676dc2c5ec395bd69c88545fac9ccfd0749dadb8ee2"
    sha256 cellar: :any, mojave:        "c229b6def61f4acc41b4b159d93dbc63a5c77f87f61623c9f7c5399da440cc4f"
    sha256 cellar: :any, high_sierra:   "939f0ad01d809356e33bdc70a8a8483eb1b021fd5f3723d0e61a2698af00f01b"
    sha256 cellar: :any, x86_64_linux:  "c12f0406fb375c08d4c9f699ec2d28099088bb999fe9cceefe9145c001f24f89" # linuxbrew-core
  end

  depends_on "gmp"
  depends_on "mpfr"

  def install
    args = %W[
      --prefix=#{prefix}
      --disable-dependency-tracking
      --with-gmp=#{Formula["gmp"].opt_prefix}
      --with-mpfr=#{Formula["mpfr"].opt_prefix}
    ]

    system "./configure", *args
    system "make"
    system "make", "check"
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <mpc.h>
      #include <assert.h>
      #include <math.h>

      int main() {
        mpc_t x;
        mpc_init2 (x, 256);
        mpc_set_d_d (x, 1., INFINITY, MPC_RNDNN);
        mpc_tanh (x, x, MPC_RNDNN);
        assert (mpfr_nan_p (mpc_realref (x)) && mpfr_nan_p (mpc_imagref (x)));
        mpc_clear (x);
        return 0;
      }
    EOS
    system ENV.cc, "test.c", "-L#{lib}", "-L#{Formula["mpfr"].opt_lib}",
                   "-L#{Formula["gmp"].opt_lib}", "-lmpc", "-lmpfr",
                   "-lgmp", "-o", "test"
    system "./test"
  end
end
