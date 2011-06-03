module MyBlog
  class FeedContent
    attr_reader :escaped

    OPEN_ESCAPE  = '<![CDATA['
    CLOSE_ESCAPE = ']]>'

    def initialize(feed)
      @escaped = feed.read
      escape('description')
      escape('content:encoded')
    end

    def escape(tag)
      @escaped.gsub!(/<\s*#{tag}\s*>/,   "<#{tag}>#{OPEN_ESCAPE}")
      @escaped.gsub!(/<\/\s*#{tag}\s*>/, "#{CLOSE_ESCAPE}</#{tag}>")
    end
  end
end
