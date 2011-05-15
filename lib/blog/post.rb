require 'date'

module Blog
  class Post
    include Comparable

    attr_reader :title, :description, :content, :publication_time

    def initialize(title, description, content, publication_time)
      @title = title
      @description = description
      @content = content
      @publication_time = publication_time
    end

    def uri
      @title
    end

    def published?
      DateTime.now >= @publication_time
    end

    def <=>(other)
      @publication_time <=> other.publication_time
    end
  end
end
