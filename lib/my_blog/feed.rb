require 'rss'

module MyBlog
  class Feed
    def initialize(uri)
      @uri = uri
    end

    def make_post_feed
      return PostFeed::Rss.new(@uri)  if rss?
      return PostFeed::Atom.new(@uri) if atom?
    end

    def content
      feed_content = ''
      open(@uri){ |uri| feed_content = uri.read }
      feed_content
    end

    def parse
      begin
        RSS::Parser.parse(content)
      rescue
        escaped_content = PostFeed::Content.new(content).escaped
        RSS::Parser.parse(escaped_content)
      end
    end

    def type
      parse.feed_type.to_sym
    end

    def rss?
      type == :rss
    end

    def atom?
      type == :atom
    end
  end
end
