class MariadbAT103 < Formula
  desc "Drop-in replacement for MySQL"
  homepage "https://mariadb.org/"
  url "https://downloads.mariadb.org/f/mariadb-10.3.30/source/mariadb-10.3.30.tar.gz"
  sha256 "bd8735c65bdb7ebcd5d779fb9d3de3f2fcd319ad6482278d73dfe7301ad4ae1b"
  license "GPL-2.0-only"
  revision 1

  livecheck do
    url "https://downloads.mariadb.org/"
    regex(/Download v?(10\.3(?:\.\d+)+) Stable Now/i)
  end

  bottle do
    sha256 big_sur:      "635d41f5b7ed95baec00e2e6c0c304eac79deb8ba4bb73f33f6be05c3d8463a8"
    sha256 catalina:     "1489cb264035dad47771304de111b1ae713e95875222fe7e7fc08ce6ccea5dc8"
    sha256 mojave:       "9d4840fd79378bfdbf6080b9aa338d4e73f322c120684bf6eb305981a4e03393"
    sha256 x86_64_linux: "6dfa6999bf26c9b7b4266aa354d32d01cdc37affd8d83dcb1b3d5c131e5eea0d" # linuxbrew-core
  end

  keg_only :versioned_formula

  # See: https://mariadb.com/kb/en/changes-improvements-in-mariadb-103/
  deprecate! date: "2023-05-01", because: :unsupported

  depends_on "bison" => :build
  depends_on "cmake" => :build
  depends_on "pkg-config" => :build
  depends_on "groonga"
  depends_on "openssl@1.1"
  depends_on "pcre2"

  uses_from_macos "bzip2"
  uses_from_macos "ncurses"
  uses_from_macos "zlib"

  on_macos do
    # Need patch to remove MYSQL_SOURCE_DIR from include path because it contains
    # file called VERSION
    # https://github.com/Homebrew/homebrew-core/pull/76887#issuecomment-840851149
    # Reported upstream at https://jira.mariadb.org/browse/MDEV-7209 - this fix can be
    # removed once that issue is closed and the fix has been merged into a stable release
    patch :DATA
  end

  on_linux do
    depends_on "gcc"
    depends_on "linux-pam"
  end

  fails_with gcc: "5"

  def install
    # Set basedir and ldata so that mysql_install_db can find the server
    # without needing an explicit path to be set. This can still
    # be overridden by calling --basedir= when calling.
    inreplace "scripts/mysql_install_db.sh" do |s|
      s.change_make_var! "basedir", "\"#{prefix}\""
      s.change_make_var! "ldata", "\"#{var}/mysql\""
    end

    # Use brew groonga
    rm_r "storage/mroonga/vendor/groonga"

    # -DINSTALL_* are relative to prefix
    args = %W[
      -DMYSQL_DATADIR=#{var}/mysql
      -DINSTALL_INCLUDEDIR=include/mysql
      -DINSTALL_MANDIR=share/man
      -DINSTALL_DOCDIR=share/doc/#{name}
      -DINSTALL_INFODIR=share/info
      -DINSTALL_MYSQLSHAREDIR=share/mysql
      -DWITH_READLINE=yes
      -DWITH_SSL=yes
      -DWITH_UNIT_TESTS=OFF
      -DDEFAULT_CHARSET=utf8mb4
      -DDEFAULT_COLLATION=utf8mb4_general_ci
      -DINSTALL_SYSCONFDIR=#{etc}
      -DCOMPILATION_COMMENT=Homebrew
    ]

    on_linux do
      args << "-DWITH_NUMA=OFF"
      args << "-DENABLE_DTRACE=NO"
      args << "-DCONNECT_WITH_JDBC=OFF"
    end

    # disable TokuDB, which is currently not supported on macOS
    args << "-DPLUGIN_TOKUDB=NO"

    system "cmake", ".", *std_cmake_args, *args

    on_macos do
      # Need to rename files called version/VERSION to avoid build failure
      # https://github.com/Homebrew/homebrew-core/pull/76887#issuecomment-840851149
      # Reported upstream at https://jira.mariadb.org/browse/MDEV-7209 - this fix can be
      # removed once that issue is closed and the fix has been merged into a stable release
      mv "storage/mroonga/version", "storage/mroonga/version.txt"
    end

    system "make"
    system "make", "install"

    # Fix my.cnf to point to #{etc} instead of /etc
    (etc/"my.cnf.d").mkpath
    inreplace "#{etc}/my.cnf", "!includedir /etc/my.cnf.d",
                               "!includedir #{etc}/my.cnf.d"
    touch etc/"my.cnf.d/.homebrew_dont_prune_me"

    # Don't create databases inside of the prefix!
    # See: https://github.com/Homebrew/homebrew/issues/4975
    rm_rf prefix/"data"

    # Save space
    (prefix/"mysql-test").rmtree
    (prefix/"sql-bench").rmtree

    # Link the setup script into bin
    bin.install_symlink prefix/"scripts/mysql_install_db"

    # Fix up the control script and link into bin
    inreplace "#{prefix}/support-files/mysql.server", /^(PATH=".*)(")/, "\\1:#{HOMEBREW_PREFIX}/bin\\2"

    bin.install_symlink prefix/"support-files/mysql.server"

    # Move sourced non-executable out of bin into libexec
    libexec.install "#{bin}/wsrep_sst_common"
    # Fix up references to wsrep_sst_common
    %w[
      wsrep_sst_mysqldump
      wsrep_sst_rsync
      wsrep_sst_mariabackup
    ].each do |f|
      inreplace "#{bin}/#{f}", "$(dirname \"$0\")/wsrep_sst_common",
                               "#{libexec}/wsrep_sst_common"
    end

    # Install my.cnf that binds to 127.0.0.1 by default
    (buildpath/"my.cnf").write <<~EOS
      # Default Homebrew MySQL server config
      [mysqld]
      # Only allow connections from localhost
      bind-address = 127.0.0.1
    EOS
    etc.install "my.cnf"
  end

  def post_install
    # Make sure the var/mysql directory exists
    (var/"mysql").mkpath

    # Don't initialize database, it clashes when testing other MySQL-like implementations.
    return if ENV["HOMEBREW_GITHUB_ACTIONS"]

    unless File.exist? "#{var}/mysql/mysql/user.frm"
      ENV["TMPDIR"] = nil
      system "#{bin}/mysql_install_db", "--verbose", "--user=#{ENV["USER"]}",
        "--basedir=#{prefix}", "--datadir=#{var}/mysql", "--tmpdir=/tmp"
    end
  end

  def caveats
    <<~EOS
      A "/etc/my.cnf" from another install may interfere with a Homebrew-built
      server starting up correctly.

      MySQL is configured to only allow connections from localhost by default

      To connect:
          mysql -uroot
    EOS
  end

  plist_options manual: "#{HOMEBREW_PREFIX}/opt/mariadb@10.3/bin/mysql.server start"

  def plist
    <<~EOS
      <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
      <plist version="1.0">
      <dict>
        <key>KeepAlive</key>
        <true/>
        <key>Label</key>
        <string>#{plist_name}</string>
        <key>ProgramArguments</key>
        <array>
          <string>#{opt_bin}/mysqld_safe</string>
          <string>--datadir=#{var}/mysql</string>
        </array>
        <key>RunAtLoad</key>
        <true/>
        <key>WorkingDirectory</key>
        <string>#{var}</string>
      </dict>
      </plist>
    EOS
  end

  test do
    (testpath/"mysql").mkpath
    (testpath/"tmp").mkpath
    system bin/"mysql_install_db", "--no-defaults", "--user=#{ENV["USER"]}",
      "--basedir=#{prefix}", "--datadir=#{testpath}/mysql", "--tmpdir=#{testpath}/tmp",
      "--auth-root-authentication-method=normal"
    port = free_port
    fork do
      system "#{bin}/mysqld", "--no-defaults", "--user=#{ENV["USER"]}",
        "--datadir=#{testpath}/mysql", "--port=#{port}", "--tmpdir=#{testpath}/tmp"
    end
    sleep 5
    assert_match "information_schema",
      shell_output("#{bin}/mysql --port=#{port} --user=root --password= --execute='show databases;'")
    system "#{bin}/mysqladmin", "--port=#{port}", "--user=root", "--password=", "shutdown"
  end
end

__END__
diff --git a/storage/mroonga/CMakeLists.txt b/storage/mroonga/CMakeLists.txt
index 555ab248751..cddb6f2f2a6 100644
--- a/storage/mroonga/CMakeLists.txt
+++ b/storage/mroonga/CMakeLists.txt
@@ -215,8 +215,7 @@ set(MYSQL_INCLUDE_DIRS
   "${MYSQL_REGEX_INCLUDE_DIR}"
   "${MYSQL_RAPIDJSON_INCLUDE_DIR}"
   "${MYSQL_LIBBINLOGEVENTS_EXPORT_DIR}"
-  "${MYSQL_LIBBINLOGEVENTS_INCLUDE_DIR}"
-  "${MYSQL_SOURCE_DIR}")
+  "${MYSQL_LIBBINLOGEVENTS_INCLUDE_DIR}")

 if(MRN_BUNDLED)
   set(MYSQL_PLUGIN_DIR "${INSTALL_PLUGINDIR}")
