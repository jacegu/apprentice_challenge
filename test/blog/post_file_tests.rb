$: << File.join(File.expand_path(File.dirname(__FILE__)), '..')

require 'test_helper'
require 'file_double'

def sample_post_file_content
  """
                  
  2011-05-08 20:00
                  
  This is the post title
                  
  This should be the post description
                  
  <h2>The content</h2>
                  
  <p>This is part of the content</p>
                  
  """
end

module Blog
  file = FileDouble.new(sample_post_file_content, false)
  @post_file = PostFile.new(file)

  test 'a post file reads the full content of the File its created from' do
    assert_equal @post_file.full_content, sample_post_file_content
  end

  test '#lines - returns the lines with text of the file content' do
    assert_equal @post_file.lines, ['2011-05-08 20:00',
                                    'This is the post title',
                                    'This should be the post description',
                                    '<h2>The content</h2>',
                                    '<p>This is part of the content</p>']
  end

  test '#publication_time - parses the first line with text as the publication time' do
    the_publication_time = DateTime.parse('2011-05-08 20:00')
    assert_equal @post_file.publication_time, the_publication_time
  end

  test '#title - takes the second line with text as the title' do
    assert_equal @post_file.title, 'This is the post title'
  end

  test '#description - takes the third line with text as the description' do
    assert_equal @post_file.description, 'This should be the post description'
  end

  test '#content - takes from 4th line to the end of the file as the content' do
    assert_equal @post_file.content, "<h2>The content</h2>\n<p>This is part of the content</p>"
  end
end
