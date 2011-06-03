class Object
  def self.yield_when_something_is_opened(resource)
    @@opened_resource = resource
  end

  def open(resource)
    yield @@opened_resource
    @@opened_resource.close
  end
end

class FeedDouble
  def initialize(content)
    @content = content
  end

  def read
    @content
  end

  def close
    @closed = true
  end

  def closed?
    @closed || false
  end
end

RSS_FEED_DOUBLE = FeedDouble.new(%{
  <?xml version='1.0' encoding='utf-8' ?>
  <rss version='2.0'
       xmlns:atom='http://www.w3.org/2005/Atom'
       xmlns:content='http://purl.org/rss/1.0/modules/content/'>
    <channel>
      <title>Testing RSS Feed</title>
      <link>http:/localhost:8583/blog</link>
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
    <link href="http:/localhost:8583/blog" />
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
