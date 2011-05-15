$: << File.join(File.expand_path(File.dirname(__FILE__)), '..')

require 'test_helper'

module Blog
  test "a blog has a configuration" do
    configuration = Configuration.new
    blog = Blog.new(configuration)
    assert_equal blog.config, configuration
  end
end
