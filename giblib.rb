class Giblib < Formula
  homepage "http://freshmeat.net/projects/giblib"
  url "http://linuxbrit.co.uk/downloads/giblib-1.2.4.tar.gz"
  mirror "http://www.mirrorservice.org/sites/distfiles.macports.org/giblib/giblib-1.2.4.tar.gz"
  sha256 "176611c4d88d742ea4013991ad54c2f9d2feefbc97a28434c0f48922ebaa8bac"

  bottle do
    cellar :any
    revision 1
    sha256 "e3e8ff19bb06a1b105e351e8c71f05a3ce92c57cc9f8f82f81d0a2f19b0f6edf" => :yosemite
    sha256 "c4622a6c22f066411a69e824f3e3fbfa6d7713d44a5f05ada8058949745ceeb4" => :mavericks
    sha256 "d326b3b552493bc46db47aeafca759afdf4e94db683445be4b3af6656fbd12b3" => :mountain_lion
  end

  depends_on :x11
  depends_on "imlib2" => :build

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system "#{bin}/giblib-config", "--version"
  end
end
