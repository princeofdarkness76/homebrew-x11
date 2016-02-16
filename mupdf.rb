class Mupdf < Formula
  homepage "http://mupdf.com"
  url "http://mupdf.com/downloads/archive/mupdf-1.8-source.tar.gz"
  sha256 "a2a3c64d8b24920f87cf4ea9339a25abf7388496440f13b37482d1403c33c206"

  bottle do
    cellar :any
    sha256 "9810926fd67c12b6303e1c133d4f890ebbbe5fcf43fcf4261e5b46afaafa28b9" => :el_capitan
    sha256 "b7a43e32a5747261e67b283e0688ccb2945a9060647c04e7b62a64fcedebe1e2" => :yosemite
    sha256 "1f1662ba5a0cf05c85fe301cc0face679f8f654689f38e3acfbe45cbd4ab43dd" => :mavericks
  end

  depends_on :macos => :snow_leopard
  depends_on :x11
  depends_on "openssl"

  conflicts_with "mupdf-tools",
    :because => "mupdf and mupdf-tools install the same binaries."

  def install
    system "make", "install",
           "build=release",
           "verbose=yes",
           "CC=#{ENV.cc}",
           "prefix=#{prefix}"
    bin.install_symlink "mutool" => "mudraw"
  end

  test do
    pdf = test_fixtures("test.pdf")
    assert_match /Homebrew test/, shell_output("#{bin}/mudraw -F txt #{pdf}")
  end
end
