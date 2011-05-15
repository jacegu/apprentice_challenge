module Blog
  class Blog
    attr_reader :name, :description, :posts

    def initialize(name, description, posts)
      @name = name
      @description = description
      @posts = posts
    end
  end
end
