$: << File.join(File.expand_path(File.dirname(__FILE__)), '..', 'lib')

require 'testing'
require 'my_blog'

def a_post_entitled(the_title)
  MyBlog::Post.new(the_title, '', '', DateTime.new)
end

def a_post_with_description(the_description)
  MyBlog::Post.new('', the_description, '', DateTime.new)
end

def a_post_with_publication_time(the_time)
  MyBlog::Post.new('', '', '', the_time)
end

def a_post_with_content(the_content)
  MyBlog::Post.new('', '', the_content, DateTime.new)
end
