class CuratorCli < Formula
  desc "A CLI tool for curating and managing Git repositories across multiple platforms"
  homepage "https://github.com/gkze/curator"
  version "0.1.4"
  if OS.mac? && Hardware::CPU.arm?
      url "https://github.com/gkze/curator/releases/download/v0.1.4/curator_cli-aarch64-apple-darwin.tar.xz"
      sha256 "8f0af25d696a2190c3f95075799a522f39ecd4e3da5ca8cac696d296dc22b3c4"
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/gkze/curator/releases/download/v0.1.4/curator_cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "ee0c4834c95911891c74cf9fd2b123d93075a37857b26dd0e80216e7c0e2fdd9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gkze/curator/releases/download/v0.1.4/curator_cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "f247246e2e2899a24eceb1cbebcb4bb8b32cb3e4cf323ba4eb2dc597f8ba9a85"
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
