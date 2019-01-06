class Stars < Formula
  desc "Explore your Github stars"
  homepage "https://github.com/gkze/stars"
  url "https://github.com/gkze/stars/releases/download/v0.4.4/stars_0.4.4_Darwin_x86_64.tar.gz"
  version "0.4.4"
  sha256 "154cbfc9bd6edea8d385ebc6e7136408608edccb71d3f699d136ed581ec900f6"

  def install
    bin.install "stars"
  end

  test do
    system  "#{bin}/stars -v"
  end
end
