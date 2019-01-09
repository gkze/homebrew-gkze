class Stars < Formula
  desc "Explore your Github stars"
  homepage "https://github.com/gkze/stars"
  url "https://github.com/gkze/stars/releases/download/v0.4.6/stars_0.4.6_Darwin_x86_64.tar.gz"
  version "0.4.6"
  sha256 "751c7f4c1af4bf50e652d2c77b881b7ff45dcc4335dfa0e4ad853aee87dd531d"

  def install
    bin.install "stars"
  end

  test do
    system  "#{bin}/stars -v"
  end
end
