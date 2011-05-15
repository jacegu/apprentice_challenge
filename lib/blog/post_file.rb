module Blog
  class PostFile
    attr_reader :full_content

    TITLE       = 1
    DESCRIPTION = 2
    CONTENT = 3..-1

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

    def lines
      lines = @full_content.split("\n")
      lines.each{ |l| l.lstrip! }
      lines.reject!{ |l| l.length == 0 }
    end
  end
end
