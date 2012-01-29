require './crake/project_task'

class DriverTask < ProjectTask
  def initialize(driver_name)
    @name = driver_name
    @config = { :target_land => :kernel }
  end
end
