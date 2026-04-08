class CuratorCli < Formula
  desc "A CLI tool for curating and managing Git repositories across multiple platforms"
  homepage "https://github.com/gkze/curator"
  version "0.6.0"
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/gkze/curator/releases/download/v0.6.0/curator_cli-aarch64-apple-darwin.tar.xz"
    sha256 "2901e4485d92bc132a77acea33d84a086416687a66557c31c53b3530fba87d83"
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/gkze/curator/releases/download/v0.6.0/curator_cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "1684a4ebb755c0446ef58323225c181fa56ed1f13aec2292e9580c24544e1893"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gkze/curator/releases/download/v0.6.0/curator_cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "211a0f896654214da79b5a4bd83fd4270042813e98b7e3924e416dd860fb2ce7"
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
