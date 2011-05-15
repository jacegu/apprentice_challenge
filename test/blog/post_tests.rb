$: << File.join(File.expand_path(File.dirname(__FILE__)), '..')

require 'test_helper'

module Blog
  test 'a post has a title' do
    the_title = 'the post title'
    post = Post.new(the_title)
    assert_equal post.title, the_title
  end
end
