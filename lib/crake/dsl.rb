require 'crake/library_task'
require 'crake/executable_task'
require 'crake/driver_task'
require 'crake/defined_tasks'

#
# define the DSL in a separate module
#

module CRake
  def library(name, args = {}, &block)
    task = LibraryTask.new(name)
    task.instance_eval &block
    DefinedTasks.add task
  end

  def executable(name, args = {}, &block)
    task = ExecutableTask.new(name)
    task.instance_eval &block
    DefinedTasks.add task
  end

  def driver(name, args = {}, &block)
    task = DriverTask.new(name)
    task.instance_eval &block
    DefinedTasks.add task
  end
end

