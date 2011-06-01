module MyBlog
  class PostFeedItem
    attr_reader :title

    def initialize(item)
      @title = item.title
      @description = item.description
      @content = item.content_encoded if item.respond_to?(:content_encoded)
    end

    def description
      if @content
        @description
      else
        ''
      end
    end

    def content
      @content || @description
    end
  end
end
