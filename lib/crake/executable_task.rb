require 'crake/project_task'

class ExecutableTask < ProjectTask
  def initialize(executable_name)
    @name = executable_name
    @config = { :target_land => :user }
  end
end
