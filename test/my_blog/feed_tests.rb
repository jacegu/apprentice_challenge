$: << File.join(File.expand_path(File.dirname(__FILE__)), '..')

require 'test_helper'
require 'feed_double'

module MyBlog
  test '#parse - returns a parsed RSS feed if the uri points to a RSS feed'do
    Object.yield_when_something_is_opened(RSS_FEED_DOUBLE)
    feed = Feed.new('http://url/to/rss')
    assert_equal feed.parse.class, RSS::Rss
  end

  test '#parse - returns a parsed Atom feed if the uri points to an Atom feed'do
    Object.yield_when_something_is_opened(ATOM_FEED_DOUBLE)
    feed = Feed.new('http://url/to/atom')
    assert_equal feed.parse.class, RSS::Atom::Feed
  end

  test '#parse - escapes XML descriptions and contents if there is a parse error' do
      bad_formatted_feed = FeedDouble.new(%{
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
              <description><<desc</description>
              <pubDate>Sat, 01 Jan 2011 10:00:00 +0000</pubDate>
              <content:encoded><<content</content:encoded>
            </item>
          </channel>
        </rss>})
      Object.yield_when_something_is_opened(bad_formatted_feed)
      assert_false Feed.new('http://url/to/rss').nil?
    end

  test '#content - reads content of the feed at the provided uri' do
    the_feed_content = 'content'
    uri = FeedDouble.new(the_feed_content)
    Object.yield_when_something_is_opened(uri)
    feed = Feed.new('http://url/to/rss')
    assert_equal feed.content, the_feed_content
  end

  test '#content - closes resource after reading it' do
    uri = FeedDouble.new('anything')
    Object.yield_when_something_is_opened(uri)
    feed = Feed.new('http://url/to/rss')
    feed.content
    assert_true uri.closed?
  end

  test '#type - if the feed is RSS returns :rss' do
    Object.yield_when_something_is_opened(RSS_FEED_DOUBLE)
    assert_equal Feed.new('http://url/to/rss').type, :rss
  end

  test '#type - if the feed is Atom returns :atom' do
    Object.yield_when_something_is_opened(ATOM_FEED_DOUBLE)
    assert_equal Feed.new('http://url/to/atom').type, :atom
  end

  test '#rss? - true if the feed type is RSS' do
    Object.yield_when_something_is_opened(RSS_FEED_DOUBLE)
    assert_true Feed.new('http://url/to/rss').rss?
  end

  test '#atom? - true if the feed type is Atom' do
    Object.yield_when_something_is_opened(ATOM_FEED_DOUBLE)
    assert_true Feed.new('http://url/to/atom').atom?
  end

  test '#make_post_feed - returns a RSS post feed if the feed is RSS' do
    Object.yield_when_something_is_opened(RSS_FEED_DOUBLE)
    feed = Feed.new('http://url/to/rss')
    assert_equal feed.make_post_feed.class, PostFeed::Rss
  end

  test '#make_post_feed - returns an Atom post feed if the feed is Atom' do
    Object.yield_when_something_is_opened(ATOM_FEED_DOUBLE)
    feed = Feed.new('http://url/to/atom')
    assert_equal feed.make_post_feed.class, PostFeed::Atom
  end
end
