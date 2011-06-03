$: << File.join(File.expand_path(File.dirname(__FILE__)), '..', '..')

require 'test_helper'
require 'feed_double'

module MyBlog
  module PostFeed
    test '#posts - returns a post for each item in the feed pointed by the uri' do
      expected_post = Post.new('title', 'desc', 'content', DateTime.parse('2011-01-01T11:00+01'))
      Object.yield_when_something_is_opened(RSS_FEED_DOUBLE)
      assert_true Rss.new('http://url/to/rss').posts.include?(expected_post)
    end

    test '#remote_uri - returns the remote uri of the feed resource' do
      Object.yield_when_something_is_opened(RSS_FEED_DOUBLE)
      assert_equal Rss.new('http://url/to/rss').remote_uri, 'http:/localhost:8583/blog'
    end
  end
end
