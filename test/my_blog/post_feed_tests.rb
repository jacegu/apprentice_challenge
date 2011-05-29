$: << File.join(File.expand_path(File.dirname(__FILE__)), '..')

require 'test_helper'
require 'feed_double'

module MyBlog
  test 'post feed takes its content from a readable uri' do
    the_feed_content = 'content'
    uri = FeedDouble.new(the_feed_content)
    feed = PostFeed.new(uri)
    assert_equal feed.content, the_feed_content
  end
end
