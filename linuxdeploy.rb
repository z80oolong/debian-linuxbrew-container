class Linuxdeploy < Formula
  desc "Package build tool for AppImage, etc."
  homepage "https://github.com/linuxdeploy/linuxdeploy"
  url "https://artifacts.assassinate-you.net/artifactory/list/linuxdeploy/travis-456/linuxdeploy-x86_64.AppImage"
  sha256 "d82b0b385979571ceb97411ab751e82c46f113427e097f7db0ad5c4b911275ec"
  version "456-travis"

  keg_only "linuxdeploy.rb is Keg only."

  option "with-extract", "Extract linuxdeploy AppImage."

  def install
    (buildpath/"linuxdeploy-x86_64.AppImage").chmod(0755)

    if build.with?("extract") then
      libexec.mkdir; bin.mkdir

      libexec.cd do
        system "#{buildpath}/linuxdeploy-x86_64.AppImage", "--appimage-extract"
      end
      (bin/"linuxdeploy").make_symlink(libexec/"squashfs-root/usr/bin/linuxdeploy")
    else
      bin.install "#{buildpath}/linuxdeploy-x86_64.AppImage" => "linuxdeploy"
    end
  end
end
