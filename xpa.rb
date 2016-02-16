class Xpa < Formula
  desc "Seamless communication between Unix programs"
  homepage "http://hea-www.harvard.edu/RD/xpa/"
  url "https://github.com/ericmandel/xpa/archive/v2.1.17.tar.gz"
  sha256 "c95ae1d6c5353226a90f29007822e98da42a036af2f7326a21d2f66189c49751"

  depends_on :x11

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"

    # relocate man, since --mandir is ignored
    mv "#{prefix}/man", man
  end
end
