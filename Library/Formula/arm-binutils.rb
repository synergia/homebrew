require 'formula'

class ArmBinutils < Formula
  url 'http://ftp.gnu.org/gnu/binutils/binutils-2.21.tar.gz'
  homepage 'http://www.gnu.org/software/binutils/binutils.html'
  md5 'f11e10f312a58d82f14bf571dd9ff91c'

  def options
    [['--default-names', "Do NOT prepend 'arm' to the binary; will override system utils."]]
  end

  def install
    args = ["--disable-debug", 
            "--disable-dependency-tracking",
            "--prefix=#{prefix}",
            "--infodir=#{info}",
            "--mandir=#{man}",
            "--target=arm-elf",
            "--enable-interwork",
            "--enable-multilib",
            "--disable-nls",
            "--disable-shared",
            "--disable-threads",
            "--with-gcc",
            "--with-gnu-as",
            "--with-gnu-ld",
            "--with-float-soft"]
    args << "--program-prefix=arm" unless ARGV.include? '--default-names'
    
    system "./configure", *args
    system "make"
    system "make install"
  end
end
