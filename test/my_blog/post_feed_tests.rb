$: << File.join(File.expand_path(File.dirname(__FILE__)), '..')

require 'test_helper'
require 'feed_double'

module MyBlog
  test 'post feed takes its content from a readable uri' do
    opened_uri = FeedDouble.new
    feed = PostFeed.new(opened_uri)
    assert_equal feed.content, opened_uri.read
  end
end
