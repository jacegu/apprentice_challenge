module MyBlog
  module PostFeed
    class Rss < Feed
      def initialize(uri)
        super(uri)
      end

      def posts
        parse.items.map{ |i| PostFeed::Item.new(i)  }
      end

      def remote_uri
        parse.channel.link
      end
    end
  end
end
