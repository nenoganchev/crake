cbs_rb_path = File.expand_path '~/.cbs.rb'
if File.exists? cbs_rb_path
  require cbs_rb_path
else
  puts "[WARNING] ~/.cbs.rb not detected, CBS may not function correctly"
  # since this is a test environment, define the variables usually defined in .cbs.rb
  $TD_TOMCRYPT_DIR = 'D:\dev\target-kit-externals\libtomcrypt'
  $TD_TOMMATH_DIR = 'D:\dev\target-kit-externals\libtommath'
  $WDK_DIR = 'D:\dev\winddk\7600.16385.0'
  $VS_DIR = 'D:\dev\vs2008'
end
