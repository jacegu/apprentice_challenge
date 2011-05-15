$: << File.join(File.expand_path(File.dirname(__FILE__)), '..')

require 'test_helper'

module Blog
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

  test 'posts are compared based in their publication time' do
    a_post     = a_post_with_publication_time(DateTime.parse('2011-01-01 00:00:00'))
    other_post = a_post_with_publication_time(DateTime.parse('2011-02-01 00:00:00'))
    assert_true a_post < other_post
    assert_true other_post > a_post
  end

  test 'a post is published if its publication time is present or past' do
    published_post = a_post_with_publication_time(DateTime.parse('2011-01-01 00:00:00'))
    assert_true published_post.published?
  end

  test 'a post has an uri which is generated from the title' do
    post_title = 'title'
    post = a_post_entitled(post_title)
    assert_equal post.uri, post_title
  end

  test 'spaces are replaces with - in the title uri' do
    post = a_post_entitled('title with several words')
    assert_equal post.uri, 'title-with-several-words'
  end
end
