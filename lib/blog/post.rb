module Blog
  class Post
    attr_reader :title

    def initialize(title)
      @title = title
    end
  end
end
