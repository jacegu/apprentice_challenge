module Blog
  class PostFile
    attr_reader :full_content

    def initialize(file)
      @full_content = file.read
    end
  end
end
