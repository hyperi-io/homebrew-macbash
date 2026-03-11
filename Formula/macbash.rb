# Project:   macbash
# File:      packaging/homebrew/macbash.rb
# Purpose:   Homebrew formula for macbash
# Language:  Ruby
#
# License:   Apache-2.0
# Copyright: (c) 2025 HyperSec Pty Ltd

class Macbash < Formula
  desc "Bash script compatibility checker for macOS"
  homepage "https://github.com/hyperi-io/macbash"
  version "1.3.0"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/hyperi-io/macbash/releases/download/v1.3.0/macbash-darwin-arm64.tar.gz"
      sha256 "cf83a1ff5e9b9c887a394739327bf6f6777523a96db6073f9c412044f8d4d55d"
    else
      url "https://github.com/hyperi-io/macbash/releases/download/v1.3.0/macbash-darwin-amd64.tar.gz"
      sha256 "d6e4fcc0bc00b34fe41d336e4ef91cc7a8ce77c3a0c67e6230c01767773e3907"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/hyperi-io/macbash/releases/download/v1.3.0/macbash-linux-arm64.tar.gz"
      sha256 "0abc2b1a923798276b635f243c843446fa3b749a36115b87e09c77ae4b6bc4af"
    else
      url "https://github.com/hyperi-io/macbash/releases/download/v1.3.0/macbash-linux-amd64.tar.gz"
      sha256 "bf59e463830d99c08265764d1d39bf9c7693447d5fd735868a20820ad393c690"
    end
  end

  def install
    bin.install "macbash"
  end

  test do
    # Test that macbash runs and shows version
    assert_match version.to_s, shell_output("#{bin}/macbash --version")

    # Test basic functionality - create a test script with a known issue
    (testpath/"test.sh").write <<~EOS
      #!/bin/bash
      grep -P '\\d+' file.txt
    EOS

    output = shell_output("#{bin}/macbash #{testpath}/test.sh 2>&1", 1)
    assert_match "grep-perl-regex", output
  end
end
