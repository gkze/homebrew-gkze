# typed: false
# frozen_string_literal: true

# This file was generated by GoReleaser. DO NOT EDIT.
class Emojictl < Formula
  desc "Manage your emojis"
  homepage "https://github.com/gkze/emojictl"
  version "0.5.0"

  on_macos do
    url "https://github.com/gkze/emojictl/releases/download/v0.5.0/emojictl_0.5.0_Darwin_x86_64.tar.gz"
    sha256 "ed941043c179a9292082a46d3d5c0e128549bdcb2fc3d20bacc69f3d5fd669e1"

    def install
      bin.install "emojictl"
    end

    if Hardware::CPU.arm?
      def caveats
        <<~EOS
          The darwin_arm64 architecture is not supported for the Emojictl
          formula at this time. The darwin_amd64 binary may work in compatibility
          mode, but it might not be fully supported.
        EOS
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/gkze/emojictl/releases/download/v0.5.0/emojictl_0.5.0_Linux_x86_64.tar.gz"
      sha256 "55b232645a1a0c45358860073a15fc469aef16c39044057a519f8fbbe3605787"

      def install
        bin.install "emojictl"
      end
    end
  end

  test do
    system  "#{bin}/emojictl -v"
  end
end
