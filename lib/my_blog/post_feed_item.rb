module MyBlog
  class PostFeedItem
    attr_reader :title
    def initialize(item)
      @title = item.title
    end
  end
end
