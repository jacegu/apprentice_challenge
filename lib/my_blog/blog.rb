module MyBlog
  class Blog
    attr_reader :name, :description, :posts

    def initialize(name, description, posts)
      @name = name
      @description = description
      @posts = posts.sort
    end

    def post_with_uri(uri)
      post = published_posts.select{ |p| p.uri == uri }[0]
      return post if post
      NullPost.new
    end

    def published_posts
      @posts.select{ |p| p.published? }
    end
  end
end
