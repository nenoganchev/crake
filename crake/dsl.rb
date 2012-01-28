
#
# define the DSL in a separate module
#

module CRake
  def library(name, args = {}, &block)
    LibraryDsl.new(name).instance_eval &block
  end

  def executable(name, args = {})
    puts "Defined executable #{name}"
  end

  def driver(name, args = {})
    puts "Defined driver #{name}"
  end

  class ProjectDsl
    def source(filepath)
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

    def link(linked_library)
      @config[:libraries] ||= []
      @config[:libraries] << linked_library
    end

    def config
      @config
    end
  end

  class LibraryDsl < ProjectDsl
    def initialize(library_name)
      @name = library_name
      @config = {}
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

