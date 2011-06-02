$: << File.join(File.expand_path(File.dirname(__FILE__)), "..")

require 'test_helper'

EntryDouble = Struct.new(:title, :summary, :updated)

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
    EntryDoubleWithoutSummary = Struct.new(:title, :updated)
    entry = EntryDoubleWithoutSummary.new('title', DateTime.now)
    post_feed_entry = PostFeedEntry.new(entry)
    assert_equal post_feed_entry.description, ''
  end

  test 'takes the publication time from the update time of the entry its created from' do
    update_time = DateTime.now
    entry = EntryDouble.new('title', 'summary', update_time)
    post_feed_entry = PostFeedEntry.new(entry)
    assert_equal post_feed_entry.publication_time, update_time
  end
end
