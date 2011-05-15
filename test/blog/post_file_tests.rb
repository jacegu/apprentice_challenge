$: << File.join(File.expand_path(File.dirname(__FILE__)), '..')

require 'test_helper'

class FileDouble
  def initialize(content)
    @content = content
  end

  def read
    @content
  end
end

def sample_post_file_content
  """
  2011-05-08 20:00
 
  
  This is the post title
   
    
  This should be the post description
     
  <h2>The content</h2>
      
  This is part of the content of the post
  <p>And this is also part of it</p>
  """
end


module Blog
  the_file = FileDouble.new(sample_post_file_content)
  @post_file = PostFile.new(the_file)

  test 'a post file reads the full content of the File its created from' do
    assert_equal @post_file.full_content, sample_post_file_content
  end

  test '#lines returns the non empty lines of the file content' do
    assert_equal @post_file.lines, ['2011-05-08 20:00',
                                    'This is the post title',
                                    'This should be the post description',
                                    '<h2>The content</h2>',
                                    'This is part of the content of the post',
                                    '<p>And this is also part of it</p>']
  end

  xtest '#publication_time takes the first line with text as the publication time'

  test '#title takes the second line with text as the title' do
    assert_equal @post_file.title, 'This is the post title'
  end

  xtest '#description takes the third line with text as the description'

  xtest '#content takes from 4th line to the end of the file as the content'
end
