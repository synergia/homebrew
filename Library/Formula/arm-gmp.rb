require 'formula'

class ArmGmp < Formula
  url 'ftp://ftp.gmplib.org/pub/gmp-5.0.2/gmp-5.0.2.tar.bz2'
  homepage 'http://gmplib.org/'
  md5 '0bbaedc82fb30315b06b1588b9077cd3'

  depends_on 'arm-binutils'

  def install
    args = ["--prefix=#{prefix}",
            "--infodir=#{info}",
            "--mandir=#{man}",
            "--with-float=soft",
            "--enable-interwork",
            "--enable-multilib"]

    system "./configure", *args
    system "make"
    system "make install"
  end
end
