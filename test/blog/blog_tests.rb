$: << File.join(File.expand_path(File.dirname(__FILE__)), '..')

require 'test_helper'

module Blog
  test 'a blog has a name' do
    the_name = 'ecomba challenge blog'
    blog = Blog.new(the_name, 'desc', [])
    assert_equal blog.name, the_name
  end

  test 'a blog has a description' do
    the_description = 'the blog has a description'
    blog = Blog.new('name', the_description, [])
    assert_equal blog.description, the_description
  end

  test 'a blog has posts' do
    the_posts = [a_post_entitled('sample post'), a_post_entitled('another post')]
    blog = Blog.new('name', 'desc', the_posts)
    assert_equal blog.posts, the_posts
  end
end
