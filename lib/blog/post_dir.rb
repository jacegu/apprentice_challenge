module Blog
  class PostDir
    attr_reader :entries, :path

    POST_FILE_NAME_PATTERN = /.*\.post\.html$/

    def initialize(dir)
      @path = dir.path
      @entries = dir.entries.select{ |e| e =~ POST_FILE_NAME_PATTERN  }
    end

    def posts
      @entries.map do |entry|
        entry_path = File.join(@path, entry)
        File.open(entry_path, 'r'){ |f| PostFile.new(f) }
      end
    end
  end
end
