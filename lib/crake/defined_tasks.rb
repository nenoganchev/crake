class DefinedTasks
  @tasks = []

  def self.add(task)
    @tasks << task
  end

  def self.get
    @tasks.dup
  end
end
