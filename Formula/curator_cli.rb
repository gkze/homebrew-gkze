class CuratorCli < Formula
  desc "A CLI tool for curating and managing Git repositories across multiple platforms"
  homepage "https://github.com/gkze/curator"
  version "0.7.0"
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/gkze/curator/releases/download/v0.7.0/curator_cli-aarch64-apple-darwin.tar.xz"
    sha256 "af3ed5104c64e6ca21e404bb9eb14f9297bfcee5d8f554e86847e4490487d80e"
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/gkze/curator/releases/download/v0.7.0/curator_cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "e852ed82fea080cfdb45c24bf8d69a7827e3211171ce462977b4380ca0bf2a70"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gkze/curator/releases/download/v0.7.0/curator_cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "89cd927b359960e47b9c7f34db311d1ec41da33b80508ec9a5ff8de5a158f5f5"
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
