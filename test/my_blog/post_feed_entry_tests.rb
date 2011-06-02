$: << File.join(File.expand_path(File.dirname(__FILE__)), "..")

require 'test_helper'

ElementDouble = Struct.new(:content)
EntryDouble = Struct.new(:title, :summary, :content, :updated)

def entry_double(title, summary, content, updated)
    title_element   = ElementDouble.new(title)
    summary_element = ElementDouble.new(summary)
    content_element = ElementDouble.new(content)
    updated_element = ElementDouble.new(updated)
    EntryDouble.new(title_element, summary_element, content_element, updated_element)
end

module MyBlog
  test 'takes the title from the entry its created from' do
    the_title = 'title'
    entry = entry_double(the_title, '', '', DateTime.now)
    post_feed_entry = PostFeedEntry.new(entry)
    assert_equal post_feed_entry.title, the_title
  end

  test 'takes the description from the summary of the entry its created from' do
    the_summary = 'summary'
    entry = entry_double('title', the_summary, '', DateTime.now)
    post_feed_entry = PostFeedEntry.new(entry)
    assert_equal post_feed_entry.description, the_summary
  end

  test 'if the entry does not have a summary the description will be empty' do
    EntryDoubleWithoutSummary = Struct.new(:title, :updated)
    entry = EntryDoubleWithoutSummary.new(ElementDouble.new('title'), ElementDouble.new(DateTime.now))
    post_feed_entry = PostFeedEntry.new(entry)
    assert_equal post_feed_entry.description, ''
  end

  test 'if the entry has a content takes its content from it' do
    the_content = 'content'
    entry = entry_double('title', 'summary', the_content, DateTime.now)
    post_feed_entry = PostFeedEntry.new(entry)
    assert_equal post_feed_entry.content, the_content
  end

  test 'if the entry has no content the content will be empty' do
    EntryDoubleWithoutContent = Struct.new(:title, :summary, :updated)
    entry = EntryDoubleWithoutContent.new(ElementDouble.new('title'),
                                          ElementDouble.new('summary'),
                                          ElementDouble.new('DateTime.new'))
    post_feed_entry = PostFeedEntry.new(entry)
    assert_equal post_feed_entry.content, ''
  end

  test 'takes the publication time from the update time of the entry its created from' do
    update_time = DateTime.now
    entry = entry_double('title', 'summary', 'content', update_time)
    post_feed_entry = PostFeedEntry.new(entry)
    assert_equal post_feed_entry.publication_time, update_time
  end

  test 'the publication time should be comparable to a DateTime' do
    update_time_as_time = Time.now
    update_time_as_datetime = update_time_as_time.to_datetime
    entry = entry_double('title', 'summary', 'content', update_time_as_time)
    post_feed_entry = PostFeedEntry.new(entry)
    assert_equal post_feed_entry.publication_time, update_time_as_datetime
  end

  test 'is equal to a post with the same title, description, content and publication time' do
    title = 'title'
    description = 'summary'
    content = 'content'
    time = DateTime.now

    post_feed_entry = PostFeedEntry.new(entry_double(title, description, content, time))
    post = Post.new(title, description, content, time)

    assert_equal post_feed_entry, post
  end
end
