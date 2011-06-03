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
      begin
        RSS::Parser.parse(content)
      rescue
        escaped_content = PostFeedContent.new(content).escaped
        RSS::Parser.parse(escaped_content)
      end
    end

    def rss?
      feed.feed_type == 'rss'
    end

    def atom?
      feed.feed_type == 'atom'
    end

    def remote_uri
      return feed.channel.link if rss?
      return feed.link.href if atom?
    end
  end
end
