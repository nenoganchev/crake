#!ruby

gem 'rake', '~> 0.9.2'
require 'rake'

#
# setup the load path so that we can require crake's files from any dir
#
crake_dir = File.expand_path(File.dirname(__FILE__))
crake_lib_dir = File.join(crake_dir, 'lib')
$LOAD_PATH.unshift crake_lib_dir unless $LOAD_PATH.include? crake_lib_dir
require 'crake/dsl'
require 'crake/defined_tasks'

#
# extend the top-level object with the DSL module, so that the namespace pollution we cause is minimal
#

self.extend CRake

#
# process the command-line arguments
#

crakefile = ARGV[0]
if crakefile == nil
  puts "[crake] error: expected the name of the crakefile as the first argument"
  exit 1
end
if not File.exists? crakefile
  puts "[crake] error: crakefile '#{crakefile}' does not exist"
  exit 1
end

#
# process the user's crakefile itself
#

crakefile_path = File.join(Dir.pwd, crakefile)
crakefile_dir = File.dirname(crakefile_path)
# set the pwd to the crakefile's directory before requiring it so that requires from the crakefile will work with paths
# relative to the crakefile itself
Dir.chdir crakefile_dir
require crakefile_path
