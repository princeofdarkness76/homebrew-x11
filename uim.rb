class Uim < Formula
  desc "Multilingual input method library"
  homepage "https://code.google.com/p/uim/"
  url "https://github.com/uim/uim/releases/download/uim-1.8.6/uim-1.8.6.tar.bz2"
  sha256 "7b1ea803c73f3478917166f04f67cce6e45ad7ea5ab6df99b948c17eb1cb235f"

  depends_on :x11
  depends_on "pkg-config" => :build
  depends_on "intltool" => :build
  depends_on "gettext"

  fails_with :clang do
    cause "Segmentation fault in uim-module-manager"
  end

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"

    # Install Emacs files in the correct directory
    mv share/"emacs/site-lisp/uim-el", share/"emacs/site-lisp/uim"
  end

  test do
    assert_equal "4", shell_output("#{bin}/uim-sh -e '(+ 2 2)'").chomp
  end
end
