require "#{PATH_TO_TOP}common.rb"

configuration 'tdcfg' do
  out_dir File.join PATH_TO_TOP, "build/crake/target_driver"
  int_dir File.join PATH_TO_TOP, "build/crake/target_driver/int"

  buffer_security_checks :off
  ignore_standard_include_paths true
  calling_convention :stdcall
  treat_compiler_warnings_as_errors :on
  warning_level 4
  debug_info_format :pdb

  define :TT_PRODUCT_VERSION => '1.0.0.37'
  define :TT_PRODUCT_VERSION_STR => '"1.0.0.37"'
  define :TT_PRODUCT_VERSION_SHA1 => '"f0290623653bd3dea857a47ddcd0b04dafb3ea0a"'
  define :TT_PRODUCT_VERSION_DATE => '"Thu Feb  9 22:50:13 2012"'
  define :TT_PRODUCT_VERSION_MAJOR => 1
  define :TT_PRODUCT_VERSION_MINOR => 0
  define :TT_PRODUCT_VERSION_PATCH => 0
  define :TT_PRODUCT_VERSION_BUILDNO => 37
  define :TT_CONFIGURATION_STR => '"Release"'
  define :_UNICODE
  define :UNICODE
  define :WINDOWS
  define :_KERNEL
  define :KERNEL
  define :i386 => 1
  define :_AMD64_
  define :IS_32
  define :CPU_LITTLE_ENDIAN
  define :ASSERT_USE_WINDOWS_KERNEL_DBG_BREAK_POINT
  define :_CRT_SECURE_NO_WARNINGS

  include_dir File.join($WDK_DIR, "inc/api")
  include_dir File.join($WDK_DIR, "inc/ddk")
  include_dir File.join($VS_DIR, "VC/include")
end

$RC_PRODUCT_VERSION = '1.0.0'
$RC_PRODUCT_VERSION_STR = %Q{"#{$RC_PRODUCT_VERSION}"}
$RC_COMPANY_NAME_STR = %Q{"Tiger Technology"}
$RC_PRODUCT_NAME_STR = %Q{"Target Kit"}
$RC_COPYRIGHT_STR = %Q{"(C) Tiger Technology"}
