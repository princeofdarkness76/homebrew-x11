class Xspringies < Formula
  desc "Interactive 2D mass/spring simulation system"
  homepage "http://www.cs.rutgers.edu/~decarlo/software.html"
  url "http://www.cs.rutgers.edu/~decarlo/software/xspringies-1.12.tar.Z"
  sha256 "08a3e9f60d1f1e15d38d62dd62baab18f6ad57ee139b0ef41452be66e4ad6a28"

  bottle do
    sha256 "4aa08b7c42d919e43e3c77de4041b6eb5cfa4cc0df5fe655ec205914799ad4a3" => :yosemite
    sha256 "8da39ce52288e954d550a8e2cdded080b85ea5bc0b46b2be23a4846dbaaeb6c4" => :mavericks
    sha256 "6bab0692a63b42be11c18783b47ddb860c4c83feb3097f84c00ef28f9fcc79ca" => :mountain_lion
  end

  depends_on :x11

  def install
    inreplace "Makefile.std" do |s|
      s.change_make_var! "LIBS", "-L#{MacOS::X11.lib} -lm -lX11"
      s.gsub! "mkdirhier", "mkdir -p"
    end
    system "make", "-f", "Makefile.std", "DDIR=#{prefix}/", "MANDIR=#{man1}", "install"
    mv "#{man1}/xspringies.man", "#{man1}/xspringies.1"
  end
end
