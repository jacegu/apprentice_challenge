$: << File.join(File.expand_path(File.dirname(__FILE__)), '..')

require 'test_helper'

module Blog
  test "a blog has a name" do
    the_name = 'ecomba challenge blog'
    blog = Blog.new(the_name)
    assert_equal blog.name, the_name
  end
end
