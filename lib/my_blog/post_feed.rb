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
      feed_items = RSS::Parser.parse(content).items
      feed_items.map{ |i| PostFeedItem.new(i) }
    end

  end
end
