class Tabbed < Formula
  homepage "http://tools.suckless.org/tabbed"
  url "http://dl.suckless.org/tools/tabbed-0.6.tar.gz"
  sha256 "7651ea3acbec5d6a25469e8665da7fc70aba2b4fa61a2a6a5449eafdfd641c42"

  bottle do
    cellar :any
    sha256 "982a6ceb32c866fd0722a4b1f532f169997a78418aec07193560b38b1ddcadf0" => :mavericks
    sha256 "978e35e95e15ced37893eda8d1c8398ec1bfc42cf3dd7abaef46fde79df3f999" => :mountain_lion
    sha256 "63e94a93cdb84b3fda35acdd2833a0350d920fcebaf6256ace0201791e32aa12" => :lion
  end

  head "http://git.suckless.org/tabbed", :using => :git

  depends_on :x11

  def install
    inreplace "config.mk", "LIBS = -L/usr/lib -lc -lX11", "LIBS = -L#{MacOS::X11.lib} -lc -lX11"
    system "make", "PREFIX=#{prefix}", "install"
  end
end
