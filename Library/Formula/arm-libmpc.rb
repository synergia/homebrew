require 'formula'

class ArmLibmpc < Formula
  url 'http://multiprecision.org/mpc/download/mpc-0.9.tar.gz'
  homepage 'http://multiprecision.org'
  md5 '0d6acab8d214bd7d1fbbc593e83dd00d'

  depends_on 'arm-gmp'
  depends_on 'arm-mpfr'

  def install
    gmp = Formula.factory 'arm-gmp'
    mpfr = Formula.factory 'arm-mpfr'
    
    args = ["--disable-dependency-tracking",
            "--prefix=#{prefix}",
            "--with-float=soft",
            "--enable-interwork",
            "--enable-multilib",
            "--target=arm-elf",
            "--with-gmp=#{gmp.prefix}",
            "--with-mpfr=#{mpfr.prefix}"]
            
    system "./configure", *args
    system "make"
    system "make install"
  end
end
