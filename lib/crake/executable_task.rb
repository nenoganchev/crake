require 'crake/project_task'

module CRake
  class ExecutableTask < ProjectTask
    def initialize(executable_name, args)
      super executable_name, args
      @config[:target_land] = :user
    end
  end
end
