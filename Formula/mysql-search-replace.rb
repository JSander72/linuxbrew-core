class MysqlSearchReplace < Formula
  desc "Database search and replace script in PHP"
  homepage "https://interconnectit.com/products/search-and-replace-for-wordpress-databases/"
  url "https://github.com/interconnectit/Search-Replace-DB/archive/4.1.2.tar.gz"
  sha256 "3da4b2af67bb820534c0e8d8dc6b87f4b38be6fe2410df90177a39dc24ae4593"
  license "GPL-3.0"

  def install
    libexec.install "srdb.class.php"
    libexec.install "srdb.cli.php" => "srdb"
    chmod 0755, libexec/"srdb"
    bin.install_symlink libexec/"srdb"
  end

  test do
    system bin/"srdb", "--help"
  end
end
