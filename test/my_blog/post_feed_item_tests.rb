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

  test 'if the item its created from has a pubDate takes the publication time from it' do
    the_date = DateTime.now
    ItemDoubleWithPubDate = Struct.new(:title, :description, :pubDate)
    item = ItemDoubleWithPubDate.new('title', 'description', the_date)
    post_feed_item = PostFeedItem.new(item)
    assert_equal post_feed_item.publication_time, the_date
  end

  test 'if the item its created does not have a pubDate takes the current time as publication time' do
    current_time = DateTime.now
    item = ItemDouble.new('title', 'description')
    post_feed_item = PostFeedItem.new(item)
    assert_true post_feed_item.publication_time > current_time
    assert_true post_feed_item.publication_time < DateTime.now
  end

  test 'the publication time is expressed as a DateTime' do
    the_date = Time.now
    the_date_as_datetime = the_date.to_datetime
    ItemDoubleWithPubDate = Struct.new(:title, :description, :pubDate)
    item = ItemDoubleWithPubDate.new('title', 'description', the_date)
    post_feed_item = PostFeedItem.new(item)
    assert_equal post_feed_item.publication_time, the_date_as_datetime
  end
end
