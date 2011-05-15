$: << File.join(File.expand_path(File.dirname(__FILE__)), '..', 'lib')

require 'testing'
require 'blog'

def a_post_entitled(the_title)
  Blog::Post.new(the_title, '', DateTime.new, '')
end

def a_post_with_description(the_description)
  Blog::Post.new('', the_description, DateTime.new, '')
end

def a_post_with_publication_time(the_time)
  Blog::Post.new('', '', the_time, '')
end

def a_post_with_content(the_content)
  Blog::Post.new('', '', DateTime.new, the_content)
end
