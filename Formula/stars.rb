class Stars < Formula
  desc "Explore your Github stars"
  homepage "https://github.com/gkze/stars"
  url "https://github.com/gkze/stars/releases/download/v0.4.0/stars_0.4.0_Darwin_x86_64.tar.gz"
  version "0.4.0"
  sha256 "6eafc2743d6cd3a3f3843c2a6aebb2ebe60f65cbed04677fb7e210d8dc7cc0bf"

  def install
    bin.install "stars"
  end

  test do
    system  "#{bin}/stars -v"
  end
end
