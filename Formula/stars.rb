class Stars < Formula
  desc "Explore your Github stars"
  homepage "https://github.com/gkze/stars"
  url "https://github.com/gkze/stars/releases/download/v0.4.7/stars_0.4.7_Darwin_x86_64.tar.gz"
  version "0.4.7"
  sha256 "2819c9917eef2fa0b7bacd30c588ad22686f80e75409e28838578099853b0764"

  def install
    bin.install "stars"
  end

  test do
    system  "#{bin}/stars -v"
  end
end
