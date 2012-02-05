module CRake
  class Configuration
    @@defined_configurations = []

    def initialize(name)
      @name = name
      @@defined_configurations << self
    end

    def self.get_defined
      @@defined_configurations
    end
  end
end
