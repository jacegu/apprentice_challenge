module MyBlog
  class PostFeedItem
    attr_reader :title, :description

    def initialize(item)
      @title = item.title
      @description = item.description
    end
  end
end
