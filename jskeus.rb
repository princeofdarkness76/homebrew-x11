class Jskeus < Formula
  desc "EusLisp software used by JSK at The University of Tokyo"
  homepage "https://github.com/euslisp/jskeus"
  url "https://github.com/euslisp/jskeus/archive/1.0.10.tar.gz"
  sha256 "038d394438dff837b9268dbec48063b33532669d5786201e2e67433fade371f1"
  head "https://github.com/euslisp/jskeus.git"

  bottle do
    cellar :any
    sha256 "fae0d5f7d1977b2d713d2809e4aed4de7c8a49c5fc1ab5bc5067107832b9ace4" => :el_capitan
    sha256 "17036543131a28767293950f64fe16946abc89bba1f54e1662cc878960320f85" => :yosemite
    sha256 "b49d9db1bdfc277e87c75f341ee2ca022a7a26d4c966c0311ad36e12a3fafb06" => :mavericks
  end

  depends_on :x11
  depends_on "jpeg"
  depends_on "libpng"
  depends_on "mesalib-glw"
  depends_on "wget" => :build

  resource "euslisp" do
    url "https://github.com/euslisp/EusLisp/archive/EusLisp-9.16.tar.gz"
    sha256 "1e60ba14d627ecb0f426bd60ea91df971855b2b076efa1c50598b420cab93a08"
  end

  def install
    ENV.deparallelize
    ENV.O0

    # jskeus needs to be compiled in Cellar
    prefix.install "Makefile", Dir["{doc,images,irteus}"]
    (prefix/"eus").install resource("euslisp")

    executables = ["eus", "eus0", "eus1", "eus2", "euscomp", "eusg", "eusgl", "eusx", "irteus", "irteusgl"]

    cd "#{prefix}" do
      system "make"

      executables.each do |exec|
        libexec.install "eus/Darwin/bin/#{exec}"
      end
    end

    bin.mkpath
    executables.each do |exec|
      (bin/exec).write <<-EOS.undent
        #!/bin/bash
        EUSDIR=#{opt_prefix}/eus ARCHDIR=Darwin LD_LIBRARY_PATH=$EUSDIR/$ARCHDIR/bin:$LD_LIBRARY_PATH exec #{libexec}/#{exec} "$@"
      EOS
    end
  end

  test do
    system "#{bin}/eus", "(exit)"
    system "#{bin}/irteusgl", "(exit)"
  end
end
