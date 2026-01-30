class CuratorCli < Formula
  desc "A CLI tool for curating and managing Git repositories across multiple platforms"
  homepage "https://github.com/gkze/curator"
  version "0.2.0"
  if OS.mac? && Hardware::CPU.arm?
      url "https://github.com/gkze/curator/releases/download/v0.2.0/curator_cli-aarch64-apple-darwin.tar.xz"
      sha256 "4576a82adcae38939646a2c2bc83a17cbd5d094debc641ad50dbc2f3ca1f15d0"
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/gkze/curator/releases/download/v0.2.0/curator_cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "6edc36b1b5bd16c2f8c5eec4b415618cb6c8408895a7fedbd6ec553b1010d069"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gkze/curator/releases/download/v0.2.0/curator_cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "aaae889c3ecae4117f3b395f298d16ec9bd6cdaa7dd8f147d6c828eecabd7f8c"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    bin.install "curator" if OS.mac? && Hardware::CPU.arm?
    bin.install "curator" if OS.linux? && Hardware::CPU.arm?
    bin.install "curator" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
