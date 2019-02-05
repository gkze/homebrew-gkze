class Stars < Formula
  desc "Explore your Github stars"
  homepage "https://github.com/gkze/stars"
  url "https://github.com/gkze/stars/releases/download/v0.4.8/stars_0.4.8_Darwin_x86_64.tar.gz"
  version "0.4.8"
  sha256 "d263c5d7b9977cd0754f8791bddff1dd5f7e343d1f7bf139b5aa5e145dc6acde"

  def install
    bin.install "stars"
  end

  test do
    system  "#{bin}/stars -v"
  end
end
