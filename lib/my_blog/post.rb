require 'date'

module MyBlog
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
      chunks = title.downcase.split
      chunks.each{ |c| c.gsub!(/\W/, '') }
      chunks.join('-')
    end

    def published?
      DateTime.now >= publication_time
    end

    def found?
      true
    end

    def ==(other)
      title == other.title and
        description == other.description and
        content == other.content and
        publication_time == other.publication_time
    end

    def <=>(other)
      other.publication_time <=> publication_time
    end
  end

  class NullPost < Post
    attr_reader :title, :description, :content, :publication_time, :uri

    def initialize
      @title = ''
      @description = ''
      @content = ''
      @publication_time = DateTime.parse('1900-01-01 00:00:00+00:00')
      @uri = ''
    end

    def published?
      false
    end

    def found?
      false
    end
  end
end
