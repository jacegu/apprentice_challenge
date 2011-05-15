require 'date'

module Blog
  class Post
    attr_reader :title, :description, :publication_time

    def initialize(title, description, publication_time)
      @title = title
      @description = description
      @publication_time = publication_time
    end
  end
end
