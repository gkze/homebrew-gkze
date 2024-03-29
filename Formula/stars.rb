# typed: false
# frozen_string_literal: true

# This file was generated by GoReleaser. DO NOT EDIT.
class Stars < Formula
  desc "Explore your Github stars"
  homepage "https://github.com/gkze/stars"
  version "0.19.24"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/gkze/stars/releases/download/v0.19.24/stars_0.19.24_Darwin_arm64.tar.gz"
      sha256 "87bc85f1c8d8e47420c214cc6cd7bc639525d1740b7a8f7b1c7d2475199e4422"

      def install
        bin.install "stars"
      end
    end
    if Hardware::CPU.intel?
      url "https://github.com/gkze/stars/releases/download/v0.19.24/stars_0.19.24_Darwin_x86_64.tar.gz"
      sha256 "51979ce85e8c89e163418b74d19b0a35e81687066c35ea59db427452c708f7a1"

      def install
        bin.install "stars"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/gkze/stars/releases/download/v0.19.24/stars_0.19.24_Linux_arm64.tar.gz"
      sha256 "897503f61678ec1eaa52bbc3f1d0caa55b63e13c999226f6cd271496d6ad8acc"

      def install
        bin.install "stars"
      end
    end
    if Hardware::CPU.intel?
      url "https://github.com/gkze/stars/releases/download/v0.19.24/stars_0.19.24_Linux_x86_64.tar.gz"
      sha256 "ff2c8681cf385539d5990039d47873c08d8c30b2f224aa2c9a5ecbbaa2c59cb7"

      def install
        bin.install "stars"
      end
    end
  end

  test do
    system  "#{bin}/stars -v"
  end
end
