class PostDir
  attr_reader :entries

  POST_FILE_NAME_PATTERN = /.*\.post\.html/

  def initialize(dir)
    @entries = dir.entries.select{ |e| e =~ POST_FILE_NAME_PATTERN  }
  end
end
