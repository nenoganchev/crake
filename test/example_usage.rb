loki_dir = 'D:\dev\loki'
tomcrypt_dir = 'D:\dev\tomcrypt'
win_sdk_dir = 'D:\dev\winsdk\win7'
path_to_top = '..'

configuration 'testcfg' do
  out_dir "out"
  int_dir "out/int"
  target_arch :x86_64
end

library 'tdlib', :type => :static, :config => 'testcfg' do

  user_land # executes in user mode or kernel mode?

  type :static # this way instead of the hash in the library call above? or support both ways?

  # list the source files
  source_file 'src/drv/string_pack.c'
  source_file 'src/lib/target_driver.cpp'
  source_file 'src/lib/scsi_disk.cpp'
  source_file 'src/lib/log.cpp'

  # list the necessary defines
  define '_LIB'
  define 'OS_64BIT' if config[:target_arch] == :intel64

  # list include directories
  include_dir "#{loki_dir}/include"
  include_dir "#{tomcrypt_dir}/src/headers"
  include_dir "#{path_to_top}/licensing/hasp/include"

  # list the required libraries. note that they are used not when building the library, but when building the
  # executables which link to this library
  lib "Advapi32.lib"
  lib "#{tomcrypt_dir}/#{config[:target_arch]}/user/tomcrypt.lib"

  # instruct the linker where to look for libraries
  library_dir "#{win_sdk_dir}/lib/#{config[:target_arch]}"
end


executable 'tdsvc', :config => 'testcfg' do
  # target_land :user is implied

  source_file 'src/svc/settings.cpp'
  source_file 'src/svc/service.cpp'
  source_file 'src/svc/web_server.cpp'

  include_dir "#{loki_dir}/include"

  lib 'tdlib' # figure out that this library is defined here and link to its full path, wherever this is
end


driver 'scsitmd', :config => 'testcfg' do
  # target_land :kernel is implied

  source_file 'src/drv/scsitmd.c'
  source_file 'src/drv/string_pack.c'

  define 'OS_64BIT' if config[:target_arch] == :intel64
  define :XMALLOC => 'malloc_kernel'  # == /DXMALLOC=malloc_kernel

  include_dir "#{tomcrypt_dir}/src/headers"

  lib "#{tomcrypt_dir}/#{config[:target_arch]}/kernel/tomcrypt.lib"
end
