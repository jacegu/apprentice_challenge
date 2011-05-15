require 'date'

module Blog
  class Post
    include Comparable

    attr_reader :title, :description, :publication_time, :content

    def initialize(title, description, publication_time, content)
      @title = title
      @description = description
      @publication_time = publication_time
      @content = content
    end

    def published?
      DateTime.now >= @publication_time
    end

    def <=>(other)
      @publication_time <=> other.publication_time
    end
  end
end
