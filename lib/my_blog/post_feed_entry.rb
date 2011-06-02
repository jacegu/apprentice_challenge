module MyBlog
  class PostFeedEntry
    attr_reader :title, :description

    def initialize(entry)
      @title = entry.title
      @description = entry.summary
    end
  end
end
