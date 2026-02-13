class CuratorCli < Formula
  desc "A CLI tool for curating and managing Git repositories across multiple platforms"
  homepage "https://github.com/gkze/curator"
  version "0.3.2"
  if OS.mac? && Hardware::CPU.arm?
      url "https://github.com/gkze/curator/releases/download/v0.3.2/curator_cli-aarch64-apple-darwin.tar.xz"
      sha256 "a7cc12964d36eb8e884c2b98cbcc21dbf35dad1e01e3c0ecd48fd0cb002aeda5"
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/gkze/curator/releases/download/v0.3.2/curator_cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "11ab02fad8bf26bf7a5b8fa3ff49faa3ba6b8ea4f619afcefb96ff6b032d0e3e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gkze/curator/releases/download/v0.3.2/curator_cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "3342ef23939815138802a1c4832c402959b0ff28f75c584647dc394d82f55e69"
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
