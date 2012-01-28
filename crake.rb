#!ruby

require './crake/dsl'

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

require File.join Dir.pwd, crakefile
