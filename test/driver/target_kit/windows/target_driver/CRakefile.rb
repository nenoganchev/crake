PATH_TO_TOP = '../../../'

require "#{PATH_TO_TOP}common.rb"
require "#{PATH_TO_TOP}target_kit/windows/common.rb"

driver 'scsitmd', :product => 'td', :config => 'tdcfg' do
  source_file 'scsitmd.c'
  source_file 'StringPack.c'
  source_file 'decrypt.c'
  source_file 'crt_replacements.c'
  source_file 'symcrypt.c'

  define :OS_64BIT if config[:target_arch] == :intel64
  define :LTM_DESC
  define :XMALLOC  => :malloc_kernel
  define :XREALLOC => :realloc_kernel
  define :XCALLOC  => :calloc_kernel
  define :XFREE    => :free_kernel
  define :XMEMSET  => :memset_kernel_undefined
  define :XMEMCPY  => :memcpy_kernel
  define :XMEMCMP  => :memcmp_kernel
  define :XSTRCMP  => :strcmp_kernel
  define :XQSORT   => :qsort_kernel_undefined
  define :XCLOCK   => :clock_kernel_undefined
  define :XCLOCKS_PER_SEC => :clocks_per_sec_kernel_undefined

  include_dir File.join($TD_TOMCRYPT_DIR, 'src/headers')

  rc_define :PRODUCT_VERSION       => $RC_PRODUCT_VERSION
  rc_define :PRODUCT_VERSION_STR   => $RC_PRODUCT_VERSION_STR
  rc_define :COMPANY_NAME_STR      => $RC_COMPANY_NAME_STR
  rc_define :FILE_DESCRIPTION_STR  => '"Target mode kit driver"'
  rc_define :INTERNAL_NAME_STR     => %Q{"#{@name}"}
  rc_define :ORIGINAL_FILENAME_STR => %Q{"#{@name}.sys"}
  rc_define :PRODUCT_NAME_STR      => $RC_PRODUCT_NAME_STR
  rc_define :COPYRIGHT_STR         => $RC_COPYRIGHT_STR

  lib File.join($TD_TOMCRYPT_DIR, 'x64/Kernel Release/tomcrypt.lib')
  lib File.join($TD_TOMMATH_DIR, 'x64/Kernel Release/tommath.lib')
end
