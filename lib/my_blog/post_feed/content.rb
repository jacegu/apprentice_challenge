module MyBlog
  module PostFeed
    class Content
      attr_reader :escaped

      OPEN_ESCAPE  = '<![CDATA['
      CLOSE_ESCAPE = ']]>'

      def initialize(content)
        @escaped = content
        escape('description')
        escape('content:encoded')
      end

      def escape(tag)
        @escaped.gsub!(/<\s*#{tag}\s*>/,   "<#{tag}>#{OPEN_ESCAPE}")
        @escaped.gsub!(/<\/\s*#{tag}\s*>/, "#{CLOSE_ESCAPE}</#{tag}>")
      end
    end
  end
end
