class FileDouble
  def initialize(content, directory)
    @content = content
    @directory = directory
  end

  def read
    @content
  end

  def directory?
    @directory
  end
end
