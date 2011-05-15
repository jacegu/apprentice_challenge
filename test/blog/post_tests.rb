$: << File.join(File.expand_path(File.dirname(__FILE__)), '..')

require 'test_helper'

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
end
