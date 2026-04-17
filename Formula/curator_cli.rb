class CuratorCli < Formula
  desc "A CLI tool for curating and managing Git repositories across multiple platforms"
  homepage "https://github.com/gkze/curator"
  version "0.7.1"
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/gkze/curator/releases/download/v0.7.1/curator_cli-aarch64-apple-darwin.tar.xz"
    sha256 "b824638b97e67d939390375cc29fc166905cf9c3096a71f69187de1c1270da1f"
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/gkze/curator/releases/download/v0.7.1/curator_cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "5831dd01c719090f8dc8400b92bfe7d56686576662c8e489f2b1939a72a2ab13"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gkze/curator/releases/download/v0.7.1/curator_cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "23c40cebdbbef8d4689525fe36f25109efcd833f8808b5b4ad2c79d4e694a0da"
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
