class Dmenu < Formula
  homepage "http://tools.suckless.org/dmenu/"
  url "http://dl.suckless.org/tools/dmenu-4.6.tar.gz"
  sha256 "4a7a24008a621c3cd656155ad91ab8136db8f0d3b9ec56dafeec518cabda96b3"

  bottle do
    cellar :any_skip_relocation
    sha256 "0b78ee676702856216bf4e627fc028ef64a0906e51806fc0ce71ec0ab0e83695" => :el_capitan
    sha256 "02ea9c17660d10e94d97325c90f29c26b95b9b4475e013d895c2b86dda4f7754" => :yosemite
    sha256 "1b68453e941e45e518eb0ea95ff0445875717d63c11ba9c95e2353e76271f94f" => :mavericks
  end

  head "http://git.suckless.org/dmenu/", :using => :git

  depends_on :x11

  def install
    system "make", "PREFIX=#{prefix}", "install"
  end

  test do
    assert_match /#{version}/, shell_output("#{bin}/dmenu -v")
  end
end
