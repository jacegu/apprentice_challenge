$: << File.join(File.expand_path(File.dirname(__FILE__)), "..")

require 'test_helper'

ItemDouble = Struct.new(:title, :description)
ItemDoubleWithContent = Struct.new(:title, :description, :content_encoded)

module MyBlog
  test 'takes the title from the item its created from' do
      the_title = 'title'
      item = ItemDouble.new(the_title, 'description')
      post_feed_item = PostFeedItem.new(item)
      assert_equal post_feed_item.title, the_title
  end

   test 'if the item its created from has enconded content takes the description from it' do
    the_description = 'description'
    item = ItemDoubleWithContent.new('title', the_description, 'content')
    post_feed_item = PostFeedItem.new(item)
    assert_equal post_feed_item.description, the_description
  end

  test 'if the item its created from has enconded content takes the content from it' do
    the_content = 'content'
    item = ItemDoubleWithContent.new('title', 'description', the_content)
    post_feed_item = PostFeedItem.new(item)
    assert_equal post_feed_item.content, the_content
  end

  test 'if the item its created from has no encoded content the description will be empty' do
    the_description = 'description'
    item = ItemDouble.new('title', the_description)
    post_feed_item = PostFeedItem.new(item)
    assert_equal post_feed_item.description, ''
  end

  test 'if the item its created from has no encoded content the content will be the description' do
    the_description  = 'content and description'
    item = ItemDouble.new('title', the_description)
    post_feed_item = PostFeedItem.new(item)
    assert_equal post_feed_item.content, the_description
  end

end
