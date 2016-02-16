class MesalibGlw < Formula
  homepage "http://www.mesa3d.org"
  url "https://downloads.sourceforge.net/project/mesa3d/MesaLib/7.2/MesaLib-7.2.tar.gz"
  sha256 "a7b7cc8201006685184e7348c47cb76aecf71be81475c71c35e3f5fe9de909c6"

  bottle do
    cellar :any
    revision 1
    sha256 "4424506e107779a8236e61aa3aa3a1cbf6fe09f75fe8655257ac9ea82058870c" => :yosemite
    sha256 "1a5f1a2480cb8ff04dc46cd59340f08d73daee7cecb2e37764ca6c23eec763b4" => :mavericks
    sha256 "d25a1e8d2cfe313ae9b843ce6e85343a362b7331eb4d6a4e380548f97774932f" => :mountain_lion
  end

  depends_on :x11

  option "enable-static", "Build static library"

  def install
    args = ["--disable-debug", "--disable-dependency-tracking",
            "--prefix=#{prefix}"]
    args << "--with-driver=xlib"
    args << "--disable-gl-osmesa"
    args << "--disable-glu"
    args << "--disable-glut"

    if build.include? "enable-static"
      args << "--enable-static"
    end

    system "./configure", *args

    inreplace "configs/autoconf" do |s|
      s.gsub! /.so/, ".dylib"
      s.gsub! /SRC_DIRS = mesa glw/, "SRC_DIRS = glw"
      s.gsub! /-L\$\(TOP\)\/\$\(LIB_DIR\)/, "-L#{MacOS::X11.lib}"
    end

    inreplace "src/glw/Makefile" do |s|
      s.gsub! /-I\$\(TOP\)\/include /, ""
    end

    system "make"

    (include+"GL").mkpath
    (include+"GL").install Dir["src/glw/*.h"]
    lib.install Dir["lib/*"]
  end
end
