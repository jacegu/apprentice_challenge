$: << File.join(File.expand_path(File.dirname(__FILE__)), "..")

require 'test_helper'

ItemDouble = Struct.new(:title, :description, :content_encoded, :pubDate)
ItemDoubleWithoutPubDate = Struct.new(:title, :description, :content_encoded)
ItemDoubleWithoutContent = Struct.new(:title, :description, :pubDate)

module MyBlog
  test 'takes the title from the item its created from' do
      the_title = 'title'
      item = ItemDouble.new(the_title, 'description', 'content', DateTime.now)
      post_feed_item = PostFeedItem.new(item)
      assert_equal post_feed_item.title, the_title
  end

   test 'if the item its created from has encoded content takes the description from it' do
    the_description = 'description'
    item = ItemDoubleWithoutPubDate.new('title', the_description, 'content')
    post_feed_item = PostFeedItem.new(item)
    assert_equal post_feed_item.description, the_description
  end

  test 'if the item its created from has encoded content takes the content from it' do
    the_content = 'content'
    item = ItemDoubleWithoutPubDate.new('title', 'description', the_content)
    post_feed_item = PostFeedItem.new(item)
    assert_equal post_feed_item.content, the_content
  end

  test 'if the item its created from has no encoded content the description will be empty' do
    the_description = 'description'
    item = ItemDoubleWithoutContent.new('title', the_description, DateTime.now)
    post_feed_item = PostFeedItem.new(item)
    assert_equal post_feed_item.description, ''
  end

  test 'if the item its created from has no encoded content the content will be the description' do
    the_description  = 'content and description'
    item = ItemDoubleWithoutContent.new('title', the_description, DateTime.now)
    post_feed_item = PostFeedItem.new(item)
    assert_equal post_feed_item.content, the_description
  end

  test 'if the item its created from has a pubDate takes the publication time from it' do
    the_date = DateTime.now
    item = ItemDoubleWithoutContent.new('title', 'description', the_date)
    post_feed_item = PostFeedItem.new(item)
    assert_equal post_feed_item.publication_time, the_date
  end

  test 'if the item its created does not have a pubDate takes the current time as publication time' do
    current_time = DateTime.now
    item = ItemDoubleWithoutPubDate.new('title', 'description', 'content')
    post_feed_item = PostFeedItem.new(item)
    assert_true post_feed_item.publication_time > current_time
    assert_true post_feed_item.publication_time < DateTime.now
  end

  test 'the publication time is expressed as a DateTime' do
    the_date = Time.now
    the_date_as_datetime = the_date.to_datetime
    item = ItemDoubleWithoutContent.new('title', 'description', the_date)
    post_feed_item = PostFeedItem.new(item)
    assert_equal post_feed_item.publication_time, the_date_as_datetime
  end

  test 'is equal to a post with the same title, description, content and publication time' do
    title = 'title'
    description = 'summary'
    content = 'content'
    time = DateTime.now

    post_feed_item = PostFeedItem.new(ItemDouble.new(title, description, content, time))
    post = Post.new(title, description, content, time)

    assert_equal post_feed_item, post
  end

end
