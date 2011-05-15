$: << File.join(File.expand_path(File.dirname(__FILE__)), '..')

require 'test_helper'

module Blog
  test 'a post file is with a path' do
    the_path = 'path/to/the/file.post.html'
    post_file = PostFile.new(the_path)
    assert_equal post_file.path, the_path
  end
end
