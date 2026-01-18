class CuratorCli < Formula
  desc "A CLI tool for curating and managing Git repositories across multiple platforms"
  homepage "https://github.com/gkze/curator"
  version "0.1.3"
  if OS.mac? && Hardware::CPU.arm?
      url "https://github.com/gkze/curator/releases/download/v0.1.3/curator_cli-aarch64-apple-darwin.tar.xz"
      sha256 "b050fb9836976a6618f612eec744c4d766ab9f336c1c02afa2fa4dd7ee73bf23"
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/gkze/curator/releases/download/v0.1.3/curator_cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "1d264b5e8e87b4c931ebae648b8ce901984e4456ce478a85652d97cfac761c3d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gkze/curator/releases/download/v0.1.3/curator_cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "744fa24df42bb554e13629eb63b452d803eadecf95f3cd0b438ba4a9b7118424"
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
