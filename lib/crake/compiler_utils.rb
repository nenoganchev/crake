require 'crake/configuration'

module CRake
  module CompilerUtils
    def compile(source_file, config, object_file)
      compiler_flags = ["/nologo", "/errorReport:none", "/c"]

      # add compiler options
      supported_compiler_options = {
        :buffer_security_checks => { true => "/GS", false => "/GS-"},
        :ignore_standard_include_paths => { true => "/X" },
        :calling_convention => { :cdecl => "/Gd", :fastcall => "/Gr", :stdcall => "/Gz" },
        :compiler_warnings_as_errors => { true => "/WX" },
        :warning_level => Hash[ (0..4).map { |n| [n, "/W#{n}"] } ],
        :debug_info_format => { :c7_compatible => "/Z7", :pdb => "/Zi", :pdb_edit_continue => "/ZI" },
      }

      add_supported_option_flags(compiler_flags, config, supported_compiler_options)

      # add include dirs
      config[:include_dirs].each { |dir| compiler_flags << "/I \"#{dir.gsub('/', '\\')}\"" }

      # add defines
      config[:defines].each do |define|
        if define.is_a? Hash
          raise "Define hash #{define} should have only one element" if define.size != 1
          define, value = define.first
          compiler_flags << "/D#{define}=#{value}"
        else
          compiler_flags << "/D#{define}"
        end
      end

      puts "[CC] #{compiler_flags.join(" ")} \"#{source_file}\" /Fo#{object_file}"
    end

    def link(object_files, config, linked_file)
      puts "[LINK] #{linked_file} from #{object_files}"
    end

    private

    def add_supported_option_flags(options_list, config, supported_options)
      supported_options.each do |option_name, supported_option_values|
        if config.has_key? option_name
          option_flag = supported_option_values[config[option_name]]
          options_list << option_flag if option_flag  # option_flag may be nil if the current option value is not supported
        end
      end
    end
  end
end
