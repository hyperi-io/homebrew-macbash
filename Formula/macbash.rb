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
  version "1.4.0"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/hyperi-io/macbash/releases/download/v1.4.0/macbash-darwin-arm64.tar.gz"
      sha256 "a15d38388900877aba49ed46b74a93765973426d48d1969af920b293a66fcdb8"
    else
      url "https://github.com/hyperi-io/macbash/releases/download/v1.4.0/macbash-darwin-amd64.tar.gz"
      sha256 "e0d8c0e2b9b575fbb041a21a477c1c875b4ccad41f5739d5233699e5613f3d35"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/hyperi-io/macbash/releases/download/v1.4.0/macbash-linux-arm64.tar.gz"
      sha256 "e5e826ecdcdd8b1a4ae4ec97764f644c84b563ead72f968e4608765313a19de9"
    else
      url "https://github.com/hyperi-io/macbash/releases/download/v1.4.0/macbash-linux-amd64.tar.gz"
      sha256 "96af19568ab2f98cfe2a98179ee54982d653c4ce7bd88d7a21a72c8db2a0d8e7"
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
