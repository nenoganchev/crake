#!ruby

gem 'rake', '~> 0.9.2'
require 'rake'
require 'optparse'

#
# setup the load path so that we can require crake's files from any dir
#
crake_dir = File.expand_path(File.dirname(__FILE__))
crake_lib_dir = File.join(crake_dir, 'lib')
$LOAD_PATH.unshift crake_lib_dir unless $LOAD_PATH.include? crake_lib_dir
require 'crake/dsl'
require 'crake/project_task'

#
# extend the top-level object with the DSL module, so that the namespace pollution we cause is minimal
#

self.extend CRake

#
# process the command-line arguments
#

options = {}
OptionParser.new do |opts|
  options[:crakefile] = 'CRakefile.rb'

  opts.on('-f', '--file CRAKEFILE', 'Specify which crakefile to process') do |f|
    options[:crakefile] = f
  end

  opts.on_tail('-h', '--help', 'Shows this help message') do
    puts opts
    exit
  end
end.parse!

if not File.exists? options[:crakefile]
  puts "[crake] error: crakefile '#{options[:crakefile]}' does not exist"
  exit 1
end

# ARGV is left with the unprocessed arguments. The first one should be the target to be built, and the rest - parameters
# that will go in crake's environment
target = ARGV.shift || "default"
if target.include? '='
  ARGV.unshift target
  target = "default"
end

env = {}
ARGV.each do |arg|
  if arg =~ /(?<lhs>.*)=(?<rhs>.*)/
    env[Regexp.last_match(:lhs)] = Regexp.last_match(:rhs)
  else
    env[arg] = true
  end
end

#
# process the user's crakefile itself
#

crakefile_path = File.join(Dir.pwd, options[:crakefile])
crakefile_dir = File.dirname(crakefile_path)
# set the pwd to the crakefile's directory before requiring it so that requires from the crakefile will work with paths
# relative to the crakefile itself
Dir.chdir crakefile_dir
require crakefile_path

#
# now build the specified projects
#

target_task = CRake::ProjectTask.get_defined.find { |t| t.name == target }
if target_task == nil
  puts "[crake] error: target #{target} not found"
  exit 1
end
target_task.build
