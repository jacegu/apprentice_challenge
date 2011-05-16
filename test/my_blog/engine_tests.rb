$: << File.join(File.expand_path(File.dirname(__FILE__)), '..')

require 'test_helper'
require 'tmpdir'
require 'uri'
require 'net/http'

PORT = 8583

def create_temporal_posts
  @post_dir_path = Dir.tmpdir
  post1 = "2011-05-08 10:00\nThe 1st post\nThe 1st post desc\n1st post content"
  post2 = "2022-05-02 09:00\nThe 2st post\nThe 2st post desc\n2st post content"
  post3 = "9999-12-31 23:59\nNot published\nNot published\nNot published"
  i = 1
  [post1, post2, post3].each do |post_content|
    post_file_path = File.join(@post_dir_path, "post-#{i}.post.html")
    File.open(post_file_path, 'w+'){ |f| f.puts post_content}
    i += 1
  end
end


def run_engine
  dir = MyBlog::PostDir.new(Dir.open(@post_dir_path))
  blog = MyBlog::Blog.new('testing engine', 'testing engine', dir.posts)
  @engine = MyBlog::Engine.new(PORT, blog)
  Thread.new{ @engine.start }
end

def stop_engine
  @engine.stop
end


def get(resource)
  url = URI.parse("http://localhost:#{PORT}/#{resource}")
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

  create_temporal_posts
  run_engine

  xtest 'main page displays all the published posts'

  xtest 'post page displays only the requested post'

  xtest 'if the requested post doesnt exists returns a 404'

  xtest 'if the requested post is not published returns a 404'

  stop_engine
end
