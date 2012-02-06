require 'crake/project_task'

module CRake
  class DriverTask < ProjectTask
    def initialize(driver_name, args)
      super driver_name, args
      @config[:target_land] = :kernel
    end
  end
end
