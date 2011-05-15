module Blog
  class PostFile
    attr_reader :path

    def initialize(path)
      @path = path
    end
  end
end
