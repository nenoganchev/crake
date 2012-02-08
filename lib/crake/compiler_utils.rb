require 'crake/configuration'

module CRake
  module CompilerUtils
    def compile(source_file, config, object_file)
      puts "[CC] #{source_file} => #{object_file}"
    end

    def link(object_files, config, linked_file)
      puts "[LINK] #{linked_file} from #{object_files}"
    end
  end
end
