$: << File.join(File.expand_path(File.dirname(__FILE__)), '..', '..')

require 'test_helper'
require 'feed_double'

module MyBlog
  module PostFeed
    Object.yield_when_something_is_opened(ATOM_FEED_DOUBLE)
    atom_post_feed = Atom.new('http://url/to/atom')

    test '#posts - returns a post for each item in the Atom feed pointed by the uri' do
      expected_post = Post.new('title', 'desc', 'content', DateTime.parse('2011-01-01T11:00:00+01:00'))
      assert_true atom_post_feed.posts.include?(expected_post)
    end

    test '#remote_uri - returns the remote uri of the atom resource' do
      assert_equal atom_post_feed.remote_uri, 'http:/localhost:8583/blog'
    end
  end
end
