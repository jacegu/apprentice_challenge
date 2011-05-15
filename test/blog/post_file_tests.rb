$: << File.join(File.expand_path(File.dirname(__FILE__)), '..')

require 'test_helper'



module Blog

  class FileDouble
    def initialize(content)
      @content = content
    end

    def read
      @content
    end
  end

  test 'a post file reads the full content of the File its created from' do
    the_content = 'the content of the file'
    the_file = FileDouble.new(the_content)
    post_file = PostFile.new(the_file)
    assert_equal post_file.full_content, the_content
  end

end
