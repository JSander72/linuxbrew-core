class Libcsv < Formula
  desc "CSV library in ANSI C89"
  homepage "https://sourceforge.net/projects/libcsv/"
  url "https://downloads.sourceforge.net/project/libcsv/libcsv/libcsv-3.0.3/libcsv-3.0.3.tar.gz"
  sha256 "d9c0431cb803ceb9896ce74f683e6e5a0954e96ae1d9e4028d6e0f967bebd7e4"
  license "GPL-2.0"

  bottle do
    rebuild 2
    sha256 cellar: :any, arm64_big_sur: "5fab325e7caac0db2cb892eebd55b5ef1094b92eaa3413bdd9ce85f47d82ff17"
    sha256 cellar: :any, big_sur:       "4edab615e912a3a0e931fff1b4f594093cfa1c4bc4869340046300b181f9ebc5"
    sha256 cellar: :any, catalina:      "e596efc37a1bf77cdbbab5fdc904e6ffa796f221b3ffa531f3ac24f56237d18a"
    sha256 cellar: :any, mojave:        "ad3c84168c138aef88134f7666f870dcb17f8b779b5e5b54417515f7c9b740af"
    sha256 cellar: :any, high_sierra:   "6946a6ff37a03f75d464cdc1229eb72251ae6b5d2726a658a016e39e862f0e33"
    sha256 cellar: :any, sierra:        "6d89efd634be6551134f099e458225325d76d69f55ba37676a3ccf7bea6c4e59"
    sha256 cellar: :any, el_capitan:    "3f69bb369fafd5c207f1c8ea500dc1e725e8e7dfe005215ff14b61fc25ac28e6"
    sha256 cellar: :any, yosemite:      "ace67ec808ae6963525164b700ace39c8552f0c68364415401fea532f3ea2fe2"
    sha256 cellar: :any, x86_64_linux:  "95782c6108e6ae72034a0cf79216685123f3d285f1afcdd2dbc9c42d39403749" # linuxbrew-core
  end

  def install
    system "./configure", "--disable-dependency-tracking", "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <csv.h>
      int main(void) {
        struct csv_parser p;
        csv_init(&p, CSV_STRICT);
      }
    EOS
    system ENV.cc, "test.c", "-I#{include}", "-L#{lib}", "-lcsv", "-o", "test"
    system "./test"
  end
end
