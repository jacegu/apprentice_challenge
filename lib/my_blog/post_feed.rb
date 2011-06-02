require 'rss'

module MyBlog
  class PostFeed
    def initialize(uri)
      @uri = uri
    end

    def content
      @uri.rewind
      @uri.read
    end

    def posts
      return feed.items.map{ |i| PostFeedItem.new(i)  } if rss?
      return feed.items.map{ |i| PostFeedEntry.new(i) } if atom?
    end

    def feed
      RSS::Parser.parse(content)
    end

    def rss?
      feed.feed_type == 'rss'
    end

    def atom?
      feed.feed_type == 'atom'
    end
  end
end
