require 'formula'

class Gitstats < Formula
  url 'http://repo.or.cz/w/gitstats.git/snapshot/c3d67a7e5bbf34bec124d71b256fa21dc910dd79.tar.gz'
  homepage 'http://gitstats.sourceforge.net/'
  md5 'f07b51c60418842cb57a2705907c6b97'

  def install
    bin.install("gitstats")
  end
end
