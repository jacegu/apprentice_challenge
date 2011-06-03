module MyBlog
  class Blog
    attr_reader :name, :description

    def initialize(name, description, post_feed)
      @name = name
      @description = description
      @post_feed = post_feed
    end

    def posts
      @post_feed.posts.sort
    end

    def post_with_uri(uri)
      if post = published_posts.select{ |p| p.uri == uri }[0]
        return post
      else
        return NullPost.new
      end
    end

    def published_posts
      posts.select{ |p| p.published? }
    end
  end
end
