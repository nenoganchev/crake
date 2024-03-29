require 'crake/library_task'
require 'crake/executable_task'
require 'crake/driver_task'
require 'crake/configuration.rb'

#
# define the DSL in a separate module
#

module CRake
  module DSL
    def library(name, args = {}, &block)
      LibraryTask.new(name, args).instance_eval &block
    end

    def executable(name, args = {}, &block)
      ExecutableTask.new(name, args).instance_eval &block
    end

    def driver(name, args = {}, &block)
      DriverTask.new(name, args).instance_eval &block
    end

    def configuration(name, args = {}, &block)
      Configuration.new(name).instance_eval &block
    end
  end
end

