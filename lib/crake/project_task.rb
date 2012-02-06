gem 'rake', '~> 0.9.2'

require 'rake'
require 'crake/configuration'

module CRake
  class ProjectTask

    #
    # initialization
    #

    @@defined_tasks = []

    def initialize(project_name, args)
      @name = project_name
      @product_name = args[:product]
      @config = Configuration.get_defined.find { |c| c.name == args[:config] } || Configuration.new
      @project_dir = Dir.pwd
      @@defined_tasks << self
    end

    #
    # DSL-implementing methods
    #

    def name(name = nil)
      # name is also used by crake's implementation as a getter, so return the name
      @name = name if name
      @name
    end

    def source_file(filepath)
      @config[:source_files] ||= []
      @config[:source_files] << filepath
    end

    def define(new_define)
      @config[:defines] ||= []
      @config[:defines] << new_define
    end

    def include_dir(new_include_dir)
      @config[:include_dirs] ||= []
      @config[:include_dirs] << new_include_dir
    end

    def library_dir(new_library_dir)
      @config[:library_dirs] ||= []
      @config[:library_dirs] << new_library_dir
    end

    def lib(linked_library)
      @config[:libraries] ||= []
      @config[:libraries] << linked_library
    end

    def rc_define(new_define)
      @config[:rc_defines] ||= []
      @config[:rc_defines] << new_define
    end

    #
    # non-DSL methods intended to be used by the client
    #

    def config
      @config
    end

    #
    # methods not intended for use by the client (intended for crake's implementation)
    #

    def to_s
      @name
    end

    def self.get_defined
      @@defined_tasks
    end

    def build
      puts "---- Building project #{@name}"
    end
  end
end
