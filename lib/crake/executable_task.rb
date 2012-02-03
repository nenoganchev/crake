require 'crake/project_task'

class ExecutableTask < ProjectTask
  def initialize(executable_name)
    super executable_name
    @config = { :target_land => :user }
  end
end
