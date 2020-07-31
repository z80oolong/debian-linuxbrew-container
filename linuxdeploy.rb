class Linuxdeploy < Formula
  desc "Package build tool for AppImage, etc."
  homepage "https://github.com/linuxdeploy/linuxdeploy"
  url "https://github.com/linuxdeploy/linuxdeploy/releases/download/continuous/linuxdeploy-x86_64.AppImage"
  sha256 "f3b5b1737d2efb1afc97d5423f2b507a31b3a89c0faae4f6472a7439d33b18a5"
  version "20200717"

  keg_only "linuxdeploy.rb is Keg only."

  option "with-extract", "Extract linuxdeploy AppImage."

  resource "completion" do
    url "https://raw.githubusercontent.com/imomaliev/tmux-bash-completion/homebrew_1.0.0/completions/tmux"
    sha256 "05e79fc1ecb27637dc9d6a52c315b8f207cf010cdcee9928805525076c9020ae"
  end

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
