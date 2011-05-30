$: << File.join(File.expand_path(File.dirname(__FILE__)), '..')

require 'test_helper'
require 'feed_double'

module MyBlog
  test '#content - returns the endpoint uri content' do
    the_feed_content = 'content'
    uri = FeedDouble.new(the_feed_content)
    feed = PostFeed.new(uri)
    assert_equal feed.content, the_feed_content
  end

  test '#content - can read endpoint any number of times' do
    uri = FeedDouble.new('anything')
    feed = PostFeed.new(uri)
    feed.content
    assert_true uri.rewinded?
  end

  test '#posts - returns a post for each item in the feed pointed by the uri' do
    publication_time = DateTime.parse('2011-01-01T11:00:00+01:00')
    expected_post = Post.new('title', 'desc', 'content', publication_time)

    feed_uri = FeedDouble.new(%{
      <?xml version='1.0' encoding='utf-8' ?>
      <rss version='2.0'
           xmlns:atom='http://www.w3.org/2005/Atom'
           xmlns:content='http://purl.org/rss/1.0/modules/content/'>
        <channel>
          <title>Testing RSS Feed</title>
          <link>http:/localhost:8583/blog/rss</link>
          <description>Testing RSS Feed</description>
          <item>
            <title>title</title>
            <description>desc</description>
            <pubDate>Sat, 01 Jan 2011 10:00:00 +0000</pubDate>
            <content:encoded>content</content:encoded>
          </item>
        </channel>
      </rss>})
    post_feed = PostFeed.new(feed_uri)

    assert_true post_feed.posts.include?(expected_post)
  end
end
