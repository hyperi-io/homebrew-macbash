# Project:   macbash
# File:      packaging/homebrew/macbash.rb
# Purpose:   Homebrew formula for macbash
# Language:  Ruby
#
# License:   Apache-2.0
# Copyright: (c) 2025-2026 HYPERI PTY LIMITED

class Macbash < Formula
  desc "Bash script compatibility checker for macOS"
  homepage "https://github.com/hyperi-io/macbash"
  version "1.5.0"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/hyperi-io/macbash/releases/download/v1.5.0/macbash-darwin-arm64.tar.gz"
      sha256 "700a194c8e72ae95d22600aae022ff9de08fba71cd115a17c44f2114bbd2a6ca"
    else
      url "https://github.com/hyperi-io/macbash/releases/download/v1.5.0/macbash-darwin-amd64.tar.gz"
      sha256 "841ed961a59eb49fc9897eb7e3c6f617f501d3abb8d1b08003204fcbc5f3fa71"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/hyperi-io/macbash/releases/download/v1.5.0/macbash-linux-arm64.tar.gz"
      sha256 "1dcada1f255c301ff159dc68af925f65c03af98528999cba6b20a92c48e6f2e3"
    else
      url "https://github.com/hyperi-io/macbash/releases/download/v1.5.0/macbash-linux-amd64.tar.gz"
      sha256 "21fabdd6304b06dadffd7fc02bc968936ef4c7fe616b222995fadb15dd4ed7d3"
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
