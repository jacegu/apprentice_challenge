class FeedDouble
  def read
  %{
<?xml version='1.0' encoding='utf-8' ?>
<rss version='2.0'
     xmlns:atom='http://www.w3.org/2005/Atom'
     xmlns:content='http://purl.org/rss/1.0/modules/content/'>
  <channel>
    <title>Testing RSS Feed</title>
    <link>http:/localhost:8583/blog/rss</link>
    <description>Testing RSS Feed</description>
    <item>
      <title>The 1st post</title>
      <description>The 1st post desc</description>
      <pubDate>Tue, 08 May 2011 10:00:00 +0000</pubDate>
      <content:encoded>1st post content</content:encoded>
    </item>
    <item>
      <title>The 2st post</title>
      <description>The 2st post desc</description>
      <pubDate>Tue, 02 May 2011 09:00:00 +0000</pubDate>
      <content:encoded>2st post content</content:encoded>
    </item>
    <item>
      <title>Not published</title>
      <description>Not published</description>
      <pubDate>Fri, 31 dec 9999 23:59:59 +0000</pubDate>
      <content:encoded>Not published</content:encoded>
    </item>
  </channel>
</rss>
  }
  end
end
