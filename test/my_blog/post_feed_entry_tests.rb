$: << File.join(File.expand_path(File.dirname(__FILE__)), "..")

require 'test_helper'

EntryDouble = Struct.new(:title, :summary)

module MyBlog
  test 'takes the title from the entry its created from' do
    the_title = 'title'
    entry = EntryDouble.new(the_title, '')
    post_feed_entry = PostFeedEntry.new(entry)
    assert_equal post_feed_entry.title, the_title
  end

  test 'takes the description from the summary of the entry its created from' do
    the_summary = 'summary'
    entry = EntryDouble.new('title', the_summary)
    post_feed_entry = PostFeedEntry.new(entry)
    assert_equal post_feed_entry.description, the_summary
  end

  test 'if the entry does not have a summary the description will be empty' do
    EntryDoubleWithoutSummary = Struct.new(:title)
    entry = EntryDoubleWithoutSummary.new('title')
    post_feed_entry = PostFeedEntry.new(entry)
    assert_equal post_feed_entry.description, ''
  end
end
