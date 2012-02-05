require 'crake/project_task'

module CRake
  class DriverTask < ProjectTask
    def initialize(driver_name)
      super driver_name
      @config = { :target_land => :kernel }
    end
  end
end
