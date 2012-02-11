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

    def has_key?(key_name)
      @store.has_key? key_name
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

    def buffer_security_checks(value)
      @store[:buffer_security_checks] = map_to_bool(value)
    end

    def ignore_standard_include_paths(value)
      @store[:ignore_standard_include_paths] = map_to_bool(value)
    end

    def calling_convention(conv_name)
      raise "Incorrect calling convention '#{conv_name}'" if not [:cdecl, :fastcall, :stdcall].include? conv_name
      @store[:calling_convention] = conv_name
    end

    def treat_compiler_warnings_as_errors(value)
      @store[:compiler_warnings_as_errors] = map_to_bool(value)
    end

    def warning_level(level)
      raise "Incorrect warning level #{level}" if not (0..4).include? level
      @store[:warning_level] = level
    end

    def debug_info_format(format)
      raise "Incorrect debug info format '#{format}'" if not [:c7_compatible, :pdb, :pdb_edit_continue].include? format
      @store[:debug_info_format] = format
    end

    def target_arch(arch)
      raise "Incorrect architecture '#{arch}'" if not [:x86, :x86_64].include? arch
      @store[:target_arch] = arch
    end

    # TODO: the project class should inherit from this class and when that happens, the methods below will no longer
    #       be duplicated

    def define(new_define)
      @store[:defines] ||= []
      @store[:defines] << new_define
    end

    def include_dir(new_include_dir)
      @store[:include_dirs] ||= []
      @store[:include_dirs] << new_include_dir
    end

    def driver(value)
      @store[:driver] = map_to_bool(value)
    end

    def ignore_default_libraries(*libs)
      @store[:ignore_default_libs] ||= []
      @store[:ignore_default_libs] |= libs
    end

    def eliminate_unreferenced_functions(value)
      @store[:opt_ref] = map_to_bool(value)
    end

    def entry(entry_function_name)
      @store[:entry] = entry_function_name
    end

    def subsystem(subsystem_name)
      subsystem_name = subsystem_name.to_sym if subsystem_name.is_a? String
      raise "Incorrect subsystem '#{subsystem_name}'" if not [:native, :windows, :console].member? subsystem_name
      @store[:subsystem] = subsystem_name
    end

    def merge(sections)
      raise "Expected a map of section names that are to be merged" if not sections.is_a? Hash
      @store[:merge] = sections
    end

    def incremental_linking(value)
      @store[:incremental] = map_to_bool(value)
    end

    def create_debug_info(value)
      @store[:create_debug_info] = map_to_bool(value)
    end

    def lib_dir(dir)
      @store[:lib_dirs] ||= []
      @store[:lib_dirs] << dir
    end

    def lib(library_name)
      @store[:libraries] ||= []
      @store[:libraries] << library_name
    end

    private

    def map_to_bool(value)
      value = value.to_sym if value.is_a? String
      {
        [:on,  true,  1] => true,
        [:off, false, 0] => false
      }.each { |mapped_values, bool_value| return bool_value if mapped_values.include? value }

      # the value was not found in the predefined set, print a warning
      caller_name = caller[0].match(/`(.*)'/)[1]
      puts "[crake] warning: value '#{value}' passed to '#{caller_name}' could not be converted to bool, returning false"
      false
    end
  end
end
