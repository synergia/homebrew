require 'formula'

class ArmGcc < Formula
  homepage 'http://gcc.gnu.org'
  url 'ftp://ftp.gnu.org/gnu/gcc/gcc-4.6.0/gcc-4.6.0.tar.bz2'
  md5 '93d1c436bf991564524701259b6285a2'

  # depends_on 'newlib'
  depends_on 'arm-gmp'
  depends_on 'arm-libmpc'
  depends_on 'arm-mpfr'

  # Dont strip compilers.
  skip_clean :all

  def install
    gmp = Formula.factory 'arm-gmp'
    mpfr = Formula.factory 'arm-mpfr'
    libmpc = Formula.factory 'arm-libmpc'

    # GCC will suffer build errors if forced to use a particular linker.
    ENV.delete 'LD'

    # Sandbox the GCC lib, libexec and include directories so they don't wander
    # around telling small children there is no Santa Claus. This results in a
    # partially keg-only brew following suggestions outlined in the "How to
    # install multiple versions of GCC" section of the GCC FAQ:
    #     http://gcc.gnu.org/faq.html#multiple
    # gcc_prefix = prefix + 'gcc'

    args = [
      # Sandbox everything...
      "--prefix=#{prefix}",
      # ...except the stuff in share...
      # "--datarootdir=#{share}",
      # ...and the binaries...
      # "--bindir=#{bin}",
      # ...which are tagged with a suffix to distinguish them.
      "--program-prefix=arm-",
      "--target=arm-elf",
      "--disable-nls",
      "--disable-shared",
      "--disable-threads",
      "--with-gcc",
      "--with-gnu-ld",
      "--with-gnu-as",
      "--with-dwarf2",
      "--enable-languages=c,c++",
      "--enable-interwork",
      "--enable-multilib",
      "--with-newlib",
      # "--with-headers=../../newlib-1.16.0/newlib/libc/include",
      "--disable-libssp",
      "--disable-libstdcxx-pch",
      "--disable-libmudflap",
      "--disable-libgomp",
      "--with-float=soft",
      "--with-gmp=#{gmp.prefix}",
      "--with-mpfr=#{mpfr.prefix}",
      "--with-mpc=#{libmpc.prefix}"]

    Dir.mkdir 'build'
    Dir.chdir 'build' do
      system '../configure', *args

      system 'make all-gcc'
      system 'make install-gcc'
      
      
      # make all-gcc
      # make install-gcc
      # build newlib # -> symlink arm-elf-cc -> arm-elf-gcc-4.6.0
      # finish with gcc
      # make
      # make install
      
      # symlink arm-elf-cc -> arm-elf-gcc-4.6.0
  
    end
  end
end