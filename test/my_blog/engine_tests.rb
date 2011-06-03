$: << File.join(File.expand_path(File.dirname(__FILE__)), '..')

require 'test_helper'
require 'feed_double'
require 'uri'
require 'net/http'

PORT = 8583

SAMPLE_FEED_CONTENT = FeedDouble.new(%{
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
      <title>The 2nd post</title>
      <description>The 2nd post desc</description>
      <pubDate>Tue, 02 May 2011 09:00:00 +0000</pubDate>
      <content:encoded>2nd post content</content:encoded>
    </item>
    <item>
      <title>Not published</title>
      <description>Not published</description>
      <pubDate>Fri, 31 dec 9999 23:59:59 +0000</pubDate>
      <content:encoded>Not published</content:encoded>
    </item>
  </channel>
</rss>
})

def run_engine
  Object.yield_when_something_is_opened(SAMPLE_FEED_CONTENT)
  feed = MyBlog::Feed.new('http://url/to/sample/rss')
  blog = MyBlog::Blog.new('testing engine', 'testing engine', feed.make_post_feed)
  @engine = MyBlog::Engine.new(PORT, blog)
  Thread.new{ @engine.start }
end

def stop_engine
  @engine.stop
end


def get(resource)
  url = URI.parse("http://localhost:#{PORT}#{resource}")
  request = Net::HTTP::Get.new(url.path)
  content = Net::HTTP.start(url.host, url.port) do |http|
    http.request(request)
  end
end


module MyBlog
  test 'Engine::Request is created from a request path uri' do
    the_uri = '/blog/a-requested-post'
    request = Engine::Request.new(the_uri)
    assert_equal request.uri, the_uri
  end

  test 'Engine::Request knows when the uri requests the blog main page' do
    assert_true  Engine::Request.new('/blog').main_page?
    assert_true  Engine::Request.new('/blog/').main_page?
    assert_false Engine::Request.new('/blog/something').main_page?
  end

  test 'Engine::Request knows when the uri requests a post' do
    assert_false  Engine::Request.new('/blog').post_page?
    assert_false  Engine::Request.new('/blog/').post_page?
    assert_false  Engine::Request.new('/blog/not-a-post-page/').post_page?
    assert_true   Engine::Request.new('/blog/something').post_page?
    assert_true   Engine::Request.new('/blog/the-requested-post').post_page?
  end

  test 'Engine::Request extracts the post uri from the request uri' do
    the_post_uri = 'a-post-uri-example'
    request = Engine::Request.new("/blog/#{the_post_uri}")
    assert_equal request.post_uri, the_post_uri
  end

  test 'Engine::Request returns empty string as post uri on main page request' do
    request = Engine::Request.new("/blog")
    assert_equal request.post_uri, ''
  end

  run_engine

  test 'main page displays all the published posts' do
    response = get '/blog'
    assert_contains response.body, 'The 1st post'
    assert_contains response.body, 'The 2nd post'
  end

  test 'main page does not display the posts that have not been published yet' do
    response = get '/blog'
    assert_does_not_contain response.body, 'Not published'
  end

  test 'post page displays only the requested post' do
    response = get '/blog/the-1st-post'
    assert_contains response.body, 'The 1st post'
    assert_does_not_contain response.body, 'The 2nd post'
  end

  test 'if the requested post doesnt exist returns a 404' do
    response = get '/blog/some-post-that-does-not-exist'
    assert_equal response.code, '404'
  end

  test 'if the requested post is not published returns a 404' do
    response = get '/blog/not-published'
    assert_equal response.code, '404'
  end

  stop_engine
end
