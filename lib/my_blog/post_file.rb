module MyBlog
  class PostFile < Post
    attr_reader :full_content

    PUBLICATION_TIME = 0
    TITLE            = 1
    DESCRIPTION      = 2
    CONTENT          = 3..-1

    def initialize(file)
      @full_content = file.read
    end

    def title
      lines[TITLE]
    end

    def description
      lines[DESCRIPTION]
    end

    def content
      lines[CONTENT].join("\n")
    end

    def publication_time
      DateTime.parse(lines[PUBLICATION_TIME])
    end

    def lines
      lines = @full_content.split("\n")
      lines.each{ |l| l.lstrip! }
      lines.reject!{ |l| l.length == 0 }
      lines
    end
  end
end
