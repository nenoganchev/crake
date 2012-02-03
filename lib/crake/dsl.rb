require 'crake/library_task'
require 'crake/executable_task'
require 'crake/driver_task'

#
# define the DSL in a separate module
#

module CRake
  def library(name, args = {}, &block)
    LibraryTask.new(name).instance_eval &block
  end

  def executable(name, args = {}, &block)
    ExecutableTask.new(name).instance_eval &block
  end

  def driver(name, args = {}, &block)
    DriverTask.new(name).instance_eval &block
  end
end

