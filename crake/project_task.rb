class ProjectTask
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
