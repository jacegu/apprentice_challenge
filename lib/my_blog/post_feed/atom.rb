module MyBlog
  module PostFeed
    class Atom < Feed
      def initialize(uri)
        @uri = uri
      end

      def posts
        parse.items.map{ |i| PostFeed::Entry.new(i) }
      end

      def remote_uri
        parse.link.href
      end
    end
  end
end
