# typed: false
# frozen_string_literal: true

# This file was generated by GoReleaser. DO NOT EDIT.
class Awssume < Formula
  desc "Go package to switch between AWS IAM Roles"
  homepage "https://github.com/gkze/awssume"
  version "0.12.4"

  on_macos do
    url "https://github.com/gkze/awssume/releases/download/v0.12.4/awssume_0.12.4_Darwin_x86_64.tar.gz"
    sha256 "a3a93c0f0eb6b01c113eb1953809081e9fbd5599dbf264a4b1c2b26f63344af4"

    def install
      bin.install "awssume"
    end

    if Hardware::CPU.arm?
      def caveats
        <<~EOS
          The darwin_arm64 architecture is not supported for the Awssume
          formula at this time. The darwin_amd64 binary may work in compatibility
          mode, but it might not be fully supported.
        EOS
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/gkze/awssume/releases/download/v0.12.4/awssume_0.12.4_Linux_x86_64.tar.gz"
      sha256 "d64b11cd3bd0d714ff7888030ae786f8cbb2e74bcfaccaabd5a51d6bb83218c4"

      def install
        bin.install "awssume"
      end
    end
  end

  test do
    system  "#{bin}/awssume -v"
  end
end
