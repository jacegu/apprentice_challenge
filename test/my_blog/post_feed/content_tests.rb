$: << File.join(File.expand_path(File.dirname(__FILE__)), "..")

require 'test_helper'

module MyBlog
  module PostFeed
    test 'if the feed is RSS escapes the description tag content' do
      content = %{
        <?xml version='1.0' encoding='utf-8' ?>
        <rss version='2.0' xmlns:atom='http://www.w3.org/2005/Atom'>
          <channel>
            <title>Testing RSS Feed</title>
            <link>http:/localhost:8583/blog/rss</link>
            <description>Testing RSS Feed</description>
            <item>
              <title>title</title>
              <description>desc</description>
              <pubDate>Sat, 01 Jan 2011 10:00:00 +0000</pubDate>
            </item>
          </channel>
        </rss>}

      feed_content = Content.new(content)

      escaped_description = /<description>.*<!\[CDATA\[.+\]\]>.*<\/description>/
      assert_true feed_content.escaped =~ escaped_description
    end

    test 'if the feed is RSS escapes the content:encoded tag content' do
      content = %{
        <?xml version='1.0' encoding='utf-8' ?>
        <rss version='2.0' xmlns:atom='http://www.w3.org/2005/Atom'>
          <channel>
            <title>Testing RSS Feed</title>
            <link>http:/localhost:8583/blog/rss</link>
            <description>Testing RSS Feed</description>
            <item>
              <title>title</title>
              <pubDate>Sat, 01 Jan 2011 10:00:00 +0000</pubDate>
              <content:encoded>content</content:encoded>
            </item>
          </channel>
        </rss>}

      feed_content = Content.new(content)

      escaped_content = /<content:encoded>.*<!\[CDATA\[.+\]\]>.*<\/content:encoded>/
      assert_true feed_content.escaped =~ escaped_content
    end
  end
end
