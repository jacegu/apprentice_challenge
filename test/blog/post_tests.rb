$: << File.join(File.expand_path(File.dirname(__FILE__)), '..')

require 'test_helper'

def a_post_entitled(the_title)
  Blog::Post.new(the_title, '')
end

def a_post_with_description(the_description)
  Blog::Post.new('', the_description)
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
end
