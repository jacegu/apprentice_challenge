$: << File.join(File.expand_path(File.dirname(__FILE__)), '..')

require 'test_helper'

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
end
