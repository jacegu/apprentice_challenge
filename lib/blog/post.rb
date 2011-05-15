require 'date'

module Blog
  class Post
    attr_reader :title, :description, :publication_time, :content

    def initialize(title, description, publication_time, content)
      @title = title
      @description = description
      @publication_time = publication_time
      @content = content
    end
  end
end
