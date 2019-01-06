class Stars < Formula
  desc "Explore your Github stars"
  homepage "https://github.com/gkze/stars"
  url "https://github.com/gkze/stars/releases/download/v0.4.2/stars_0.4.2_Darwin_x86_64.tar.gz"
  version "0.4.2"
  sha256 "b3723e749bba849af51bc82cf36cdf6442d940e5a0c8aab4f2bf4489de74ee45"

  def install
    bin.install "stars"
  end

  test do
    system  "#{bin}/stars -v"
  end
end
