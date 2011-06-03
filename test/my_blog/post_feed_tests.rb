$: << File.join(File.expand_path(File.dirname(__FILE__)), '..')

require 'test_helper'
require 'feed_double'

RSS_FEED_DOUBLE = FeedDouble.new(%{
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

ATOM_FEED_DOUBLE = FeedDouble.new(%{
  <?xml version='1.0' encoding='utf-8' ?>
  <feed xmlns="http://www.w3.org/2005/Atom">
    <id>urn:uuid:60a76c80-d399-11d9-b93C-0003939e0af6</id>
    <title>Testing Atom Feed</title>
    <subtitle>Testing Atom Feed</subtitle>
    <link href="http:/localhost:8583/blog/rss" />
    <author>
      <name>John Doe</name>
      <email>johndoe@example.com</email>
    </author>
    <updated>2003-12-13T18:30:02Z</updated>
    <entry>
        <id>urn:uuid:1225c695-cfb8-4ebb-aaaa-80da344efa6a</id>
        <title>title</title>
        <updated>2011-01-01T11:00:00+01:00</updated>
        <summary>desc</summary>
        <content>content</content>
    </entry>
  </feed>})

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

  test '#rss? - returns true if the feed is an RSS feed' do
    post_feed = PostFeed.new(RSS_FEED_DOUBLE)
    assert_true post_feed.rss?
  end

  test '#atom? - returns true if the feed is an Atom feed' do
    post_feed = PostFeed.new(ATOM_FEED_DOUBLE)
    assert_true post_feed.atom?
  end

  test '#posts - returns a post for each item in the RSS feed pointed by the uri' do
    publication_time = DateTime.parse('2011-01-01T11:00:00+01:00')
    expected_post = Post.new('title', 'desc', 'content', publication_time)

    post_feed = PostFeed.new(RSS_FEED_DOUBLE)

    assert_true post_feed.posts.include?(expected_post)
  end

  test '#posts - returns a post for each item in the Atom feed pointed by the uri' do
    publication_time = DateTime.parse('2011-01-01T11:00:00+01:00')
    expected_post = Post.new('title', 'desc', 'content', publication_time)

    post_feed = PostFeed.new(ATOM_FEED_DOUBLE)

    assert_true post_feed.posts.include?(expected_post)
  end

  test '#posts - escapes the feed content if there is an error parsing the posts' do
    publication_time = DateTime.parse('2011-01-01T11:00:00+01:00')
    expected_post = Post.new('title', '<<<<desc', '<<<<content', publication_time)

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
            <description><<<<desc</description>
            <pubDate>Sat, 01 Jan 2011 10:00:00 +0000</pubDate>
            <content:encoded><<<<content</content:encoded>
          </item>
        </channel>
      </rss>})

    post_feed = PostFeed.new(bad_formatted_feed)

    assert_true post_feed.posts.include?(expected_post)
  end
end
