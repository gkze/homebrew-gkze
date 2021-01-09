# typed: false
# frozen_string_literal: true

# This file was generated by GoReleaser. DO NOT EDIT.
class Stars < Formula
  desc "Explore your Github stars"
  homepage "https://github.com/gkze/stars"
  version "0.11.24"
  bottle :unneeded

  if OS.mac?
    url "https://github.com/gkze/stars/releases/download/v0.11.24/stars_0.11.24_Darwin_x86_64.tar.gz"
    sha256 "5591dc9456fbd0f04944be52e32a72031ef5da993f9c50343c75c64be63ce04b"
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/gkze/stars/releases/download/v0.11.24/stars_0.11.24_Linux_x86_64.tar.gz"
    sha256 "6609c53d10a4137c70f46a3fe21b0227af0dfe4aee2322f81ea409950f2d6921"
  end

  def install
    bin.install "stars"
  end

  test do
    system  "#{bin}/stars -v"
  end
end
