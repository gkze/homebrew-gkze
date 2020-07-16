# This file was generated by GoReleaser. DO NOT EDIT.
class Stars < Formula
  desc "Explore your Github stars"
  homepage "https://github.com/gkze/stars"
  version "0.10.23"
  bottle :unneeded

  if OS.mac?
    url "https://github.com/gkze/stars/releases/download/v0.10.23/stars_0.10.23_Darwin_x86_64.tar.gz"
    sha256 "3add6df8bca7cc8806b99e2eb8f49e8df0f14a53c7da695a57169a17e001fd68"
  elsif OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/gkze/stars/releases/download/v0.10.23/stars_0.10.23_Linux_x86_64.tar.gz"
      sha256 "c9da32caf3f13b3bac198299433d1bb1a46ed2b287b7d86baecedec0535cc465"
    end
  end

  def install
    bin.install "stars"
  end

  test do
    system  "#{bin}/stars -v"
  end
end
