$: << File.join(File.expand_path(File.dirname(__FILE__)), "..")

require 'test_helper'

ItemDouble = Struct.new(:title, :description)

module MyBlog
  test 'takes the title from the item its created from' do
      the_title = 'title'
      item = ItemDouble.new(the_title, 'description')
      post_feed_item = PostFeedItem.new(item)
      assert_equal post_feed_item.title, the_title
  end

  test 'takes the description from the item its created from' do
    the_description = 'description'
    item = ItemDouble.new('title', the_description)
    post_feed_item = PostFeedItem.new(item)
    assert_equal post_feed_item.description, the_description
  end
end
