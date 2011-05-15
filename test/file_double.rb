class File
  alias :old_open :open

  @@files_to_yield = {}

  def self.yield_file_when_opening(file, path)
    @@files_to_yield[path] = file
  end

  def self.open(path, *rest, &block)
    if @@files_to_yield.has_key?(path)
      yield @@files_to_yield[path]
    else
      old_open(path)
    end
  end
end

class FileDouble
  def initialize(content)
    @content = content
  end

  def read
    @content
  end
end
