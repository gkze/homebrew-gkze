class CuratorCli < Formula
  desc "A CLI tool for curating and managing Git repositories across multiple platforms"
  homepage "https://github.com/gkze/curator"
  version "0.1.6"
  if OS.mac? && Hardware::CPU.arm?
      url "https://github.com/gkze/curator/releases/download/v0.1.6/curator_cli-aarch64-apple-darwin.tar.xz"
      sha256 "b485ef9f33042b07473194a8bee6e47a2f826394657cee3ad48221778349a213"
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/gkze/curator/releases/download/v0.1.6/curator_cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "f0dd6b1712f9e28faaef4192753211f4b4d58414c4e1c1867ff52a46feda1a3d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gkze/curator/releases/download/v0.1.6/curator_cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "d07ffc6dcf302c6e5f906a3d07c09c2a649154c613ce82ed99d35ff3682353b1"
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
