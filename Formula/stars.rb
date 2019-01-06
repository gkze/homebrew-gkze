class Stars < Formula
  desc "Explore your Github stars"
  homepage "https://github.com/gkze/stars"
  url "https://github.com/gkze/stars/releases/download/v0.4.5/stars_0.4.5_Darwin_x86_64.tar.gz"
  version "0.4.5"
  sha256 "2bee4efd875aa403c3f4c37f2b647c2a9b28f542182a282cb1f27ac3b1a6aeaf"

  def install
    bin.install "stars"
  end

  test do
    system  "#{bin}/stars -v"
  end
end
