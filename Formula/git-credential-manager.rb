class GitCredentialManager < Formula
  desc "Stores Git credentials for Visual Studio Team Services"
  homepage "https://docs.microsoft.com/vsts/git/set-up-credential-managers"
  url "https://github.com/Microsoft/Git-Credential-Manager-for-Mac-and-Linux/releases/download/git-credential-manager-2.0.4/git-credential-manager-2.0.4.jar"
  sha256 "fb8536aac9b00cdf6bdeb0dd152bb1306d88cd3fdb7a958ac9a144bf4017cad7"
  license "MIT"
  revision 2

  # "This project has been superceded by Git Credential Manager Core":
  # https://github.com/microsoft/Git-Credential-Manager-Core
  deprecate! date: "2020-10-01", because: :repo_archived

  depends_on "openjdk"

  def install
    libexec.install "git-credential-manager-#{version}.jar"
    bin.write_jar_script libexec/"git-credential-manager-#{version}.jar", "git-credential-manager"
  end

  test do
    system "#{bin}/git-credential-manager", "version"
  end
end
