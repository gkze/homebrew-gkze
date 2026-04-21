class CuratorCli < Formula
  desc "A CLI tool for curating and managing Git repositories across multiple platforms"
  homepage "https://github.com/gkze/curator"
  version "0.7.2"
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/gkze/curator/releases/download/v0.7.2/curator_cli-aarch64-apple-darwin.tar.xz"
    sha256 "29efa5c7807a07f963d323e86786f0a7655b7e00735ad395b6c374a9bbbd3140"
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/gkze/curator/releases/download/v0.7.2/curator_cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "c8cd38b99d17372eed9d2742d683ff2ca034e96fd43acac311b458edad3dfdb5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gkze/curator/releases/download/v0.7.2/curator_cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "804d35c67a34f3d97d7be416a4f609ab2da5902c7fe80be633ce9d2cc5683fe5"
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
