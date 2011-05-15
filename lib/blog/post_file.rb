module Blog
  class PostFile

    TITLE_LINE = 1

    attr_reader :full_content

    def initialize(file)
      @full_content = file.read
    end

    def title
      lines[TITLE_LINE]
    end

    def lines
      lines = @full_content.split("\n")
      lines.each{ |l| l.lstrip! }
      lines.reject!{ |l| l.length == 0 }
    end
  end
end
