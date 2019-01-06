class Stars < Formula
  desc "Explore your Github stars"
  homepage "https://github.com/gkze/stars"
  url "https://github.com/gkze/stars/releases/download/v0.4.1/stars_0.4.1_Darwin_x86_64.tar.gz"
  version "0.4.1"
  sha256 "9465a47ca1d71a73dfa46c594d7ce6aaacc1c6f53526881fdbf4e25ff08a7c80"

  def install
    bin.install "stars"
  end

  test do
    system  "#{bin}/stars -v"
  end
end
