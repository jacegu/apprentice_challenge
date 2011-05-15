module MyBlog
  class Blog
    attr_reader :name, :description, :posts

    def initialize(name, description, posts)
      @name = name
      @description = description
      @posts = posts.sort
    end

    def published_posts
      @posts.select{ |p| p.published? }
    end
  end
end
