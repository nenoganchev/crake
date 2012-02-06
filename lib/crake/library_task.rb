require 'crake/project_task'

module CRake
  class LibraryTask < ProjectTask
    def initialize(library_name, args)
      super library_name, args
    end

    def user_land
      @config[:target_land] = :user
    end

    def type(library_type)
      raise "Incorrect library type" if not [:static, :dynamic].member? library_type
      @config[:library_type] = library_type
    end
  end
end
