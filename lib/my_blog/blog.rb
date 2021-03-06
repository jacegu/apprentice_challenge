module MyBlog
  class Blog
    attr_reader :name, :description

    def initialize(name, description, dir)
      @name = name
      @description = description
      @dir = dir
    end

    def posts
      @dir.posts.sort
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
