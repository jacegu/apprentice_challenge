$: << File.join(File.expand_path(File.dirname(__FILE__)), '..')

require 'test_helper'

class PostDirDouble
  attr_reader :posts

  def initialize(posts)
    @posts = posts
  end
end

module MyBlog
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

  test 'a blog has post dir where it takes its posts from' do
    the_posts = [a_post_entitled('sample post'), a_post_entitled('another post')]
    post_dir = PostDirDouble.new(the_posts)
    blog = Blog.new('name', 'desc', post_dir)

    assert_equal blog.posts, the_posts
  end

  test 'the blog posts are ordered by publication time' do
    first_post  = a_post_with_publication_time(DateTime.parse('2011-01-01 09:00:00'))
    second_post = a_post_with_publication_time(DateTime.parse('2011-01-01 09:00:01'))
    third_post  = a_post_with_publication_time(DateTime.parse('2011-01-01 09:00:02'))

    post_dir = PostDirDouble.new([third_post, first_post, second_post])
    blog = Blog.new('name', 'desc', post_dir)

    assert_equal blog.posts[2], first_post
    assert_equal blog.posts[1], second_post
    assert_equal blog.posts[0], third_post
  end

  test '#published_posts - returns the posts that are published' do
    published     = a_post_with_publication_time(DateTime.parse('2011-01-01 09:00:00'))
    not_published = a_post_with_publication_time(DateTime.parse('9999-01-01 09:00:01'))

    post_dir = PostDirDouble.new([published, not_published])
    blog = Blog.new('name', 'desc', post_dir)

    assert_equal blog.published_posts, [published]
  end

  test '#post_with_uri - finds a post with given uri among published posts' do
    searched      = Post.new('post title', 'd', 'c', DateTime.parse('2011-01-01 09:00:00'))
    not_published = a_post_with_publication_time(DateTime.parse('9999-01-01 09:00:01'))

    post_dir = PostDirDouble.new([searched, not_published])
    blog = Blog.new('name', 'desc', post_dir)

    assert_equal blog.post_with_uri('post-title'), searched
  end

  test '#post_with_uri - returns null post if no post with given uri exists' do
    null_post = NullPost.new
    blog = Blog.new('name', 'desc', PostDirDouble.new([]))
    assert_equal blog.post_with_uri('any-uri'), null_post
  end
end
