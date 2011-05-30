require 'rss'

module MyBlog
  class PostFeed
    def initialize(uri)
      @uri = uri
    end

    def content
      @uri.read
    end

    def posts
      feed_items = RSS::Parser.parse(content).items
      feed_items.map{ |i| post_from_item(i) }
    end

    def post_from_item(item)
      Post.new(item.title, item.description, item.content_encoded, item.pubDate.to_datetime)
    end
  end
end
