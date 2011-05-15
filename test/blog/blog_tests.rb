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

  test 'the blog posts are ordered by publication time' do
    first_post  = a_post_with_publication_time(DateTime.parse('2011-01-01 09:00:00'))
    second_post = a_post_with_publication_time(DateTime.parse('2011-01-01 09:00:01'))
    third_post  = a_post_with_publication_time(DateTime.parse('2011-01-01 09:00:02'))

    blog = Blog.new('name', 'desc', [third_post, first_post, second_post])

    assert_equal blog.posts[0], first_post
    assert_equal blog.posts[1], second_post
    assert_equal blog.posts[2], third_post
  end
end
