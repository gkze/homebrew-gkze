class Stars < Formula
  desc "Explore your Github stars"
  homepage "https://github.com/gkze/stars"
  url "https://github.com/gkze/stars/releases/download/v0.4.3/stars_0.4.3_Darwin_x86_64.tar.gz"
  version "0.4.3"
  sha256 "462e6812caa3de5884a5c378bc798ee742f545d9faed5f83ffbfb1d63dffcd67"

  def install
    bin.install "stars"
  end

  test do
    system  "#{bin}/stars -v"
  end
end
