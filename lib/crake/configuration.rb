module CRake
  class Configuration
    attr_reader :name

    @@defined_configurations = []

    def self.get_defined
      @@defined_configurations
    end

    def initialize(name = "")
      @name = name
      @store = {}
      @@defined_configurations << self
    end

    def [](key)
      @store[key]
    end

    def []=(key, value)
      @store[key] = value
    end

    #
    # DSL-implementing methods
    #

    def out_dir(dir)
      @store[:out_dir] = dir
    end

    def int_dir(dir)
      @store[:int_dir] = dir
    end
  end
end
