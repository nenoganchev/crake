require 'crake/configuration'

module CRake
  module CompilerUtils
    def compile(source_file, config, object_file)
      compiler_flags = ["/nologo", "/errorReport:none", "/c"]

      # add compiler options
      {
        :buffer_security_checks => { true => "/GS", false => "/GS-"},
        :ignore_standard_include_paths => { true => "/X" },
        :calling_convention => { :cdecl => "/Gd", :fastcall => "/Gr", :stdcall => "/Gz" },
        :compiler_warnings_as_errors => { true => "/WX" },
        :warning_level => Hash[ (0..4).map { |n| [n, "/W#{n}"] } ],
        :debug_info_format => { :c7_compatible => "/Z7", :pdb => "/Zi", :pdb_edit_continue => "/ZI" },
      }.each do |setting_name, setting_flags|
        if config.has_key? setting_name
          setting_flag = setting_flags[config[setting_name]]
          compiler_flags << setting_flag if setting_flag  # setting_flag may be nil when a compiler flag doesn't have an opposite
        end
      end

      # add include dirs

      # add defines

      puts "[CC] #{source_file} #{compiler_flags} -o #{object_file}"
    end

    def link(object_files, config, linked_file)
      puts "[LINK] #{linked_file} from #{object_files}"
    end
  end
end
