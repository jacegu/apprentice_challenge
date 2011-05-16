#encoding: utf-8

require 'test_helper'

module MyBlog
  test 'a post has a title' do
    the_title = 'the post title'
    post = a_post_entitled(the_title)
    assert_equal post.title, the_title
  end

  test 'a post has a description' do
    the_description = 'the post description'
    post = a_post_with_description(the_description)
    assert_equal post.description, the_description
  end

  test 'a post has a time it will be published at' do
    the_time = DateTime.new
    post = a_post_with_publication_time(the_time)
    assert_equal post.publication_time, the_time
  end

  test 'a post has a content' do
    the_content = 'some content'
    post = a_post_with_content(the_content)
    assert_equal post.content, the_content
  end

  test "posts are equal if they've the same title, description, publication time and content" do
    now = DateTime.now
    a_post     = Post.new('t', 'd', 'c', now)
    other_post = Post.new('t', 'd', 'c', now)
    assert_equal a_post, other_post
  end

  test 'posts are different if they have different title' do
    now = DateTime.now
    a_post     = Post.new('x', 'd', 'c', now)
    other_post = Post.new('t', 'd', 'c', now)
    assert_not_equal a_post, other_post
  end

  test 'posts are different if they have different description' do
    now = DateTime.now
    a_post     = Post.new('t', 'x', 'c', now)
    other_post = Post.new('t', 'd', 'c', now)
    assert_not_equal a_post, other_post
  end

  test 'posts are different if they have different content' do
    now = DateTime.now
    a_post     = Post.new('t', 'd', 'x', now)
    other_post = Post.new('t', 'd', 'c', now)
    assert_not_equal a_post, other_post
  end

  test 'posts are different if they have different publication time' do
    a_post     = Post.new('t', 'd', 'c', DateTime.now)
    other_post = Post.new('t', 'd', 'c', DateTime.now)
    assert_not_equal a_post, other_post
  end

  test 'posts are compared based in their publication time' do
    a_post     = a_post_with_publication_time(DateTime.parse('2011-01-01 00:00:00'))
    other_post = a_post_with_publication_time(DateTime.parse('2011-02-01 00:00:00'))
    assert_true a_post < other_post
    assert_true other_post > a_post
  end

  test 'post is published if its publication time is present or past' do
    published_post = a_post_with_publication_time(DateTime.parse('2011-01-01 00:00:00'))
    assert_true published_post.published?
  end

  test '#uri - a post has its title as uri' do
    post_title = 'title'
    post = a_post_entitled(post_title)
    assert_equal post.uri, post_title
  end

  test '#uri - spaces are replaced with scripts ("-") in the uri' do
    post = a_post_entitled('title with several words')
    assert_equal post.uri, 'title-with-several-words'
  end

  test '#uri - non alphanumeric characters are removed from the uri' do
    post = a_post_entitled('t1?t)l%3 w1#t@h s0ºm3 [s+ym=b0ls]')
    assert_equal post.uri, 't1tl3-w1th-s0m3-symb0ls'
  end

  test 'posts are always found' do
    assert_true a_post_entitled('title').found?
  end

  test 'NullPost - has empty title' do
    assert_equal NullPost.new.title, ''
  end

  test 'NullPost - has empty description' do
    assert_equal NullPost.new.description, ''
  end

  test 'NullPost - has empty content' do
    assert_equal NullPost.new.content, ''
  end

  test 'NullPost - has a publication date 1900-01-01 00:00:00+00:00' do
    expected_publication_date = DateTime.parse('1900-01-01 00:00:00+00:00')
    assert_equal NullPost.new.publication_time, expected_publication_date
  end

  test 'NullPost - has empty uri' do
    assert_equal NullPost.new.uri, ''
  end

  test 'NullPost - is never published' do
    assert_false NullPost.new.published?
  end

  test 'NullPost - is never found' do
    assert_false NullPost.new.found?
  end
end
