$: << File.join(File.expand_path(File.dirname(__FILE__)), '..')

require 'test_helper'

class DirDouble
  attr_reader :path, :entries

  def initialize(entries)
    @entries = entries
    @entries << '.'
    @entries << '..'
  end
end

module Blog
  entries = ['regular_file.txt',
             '.hidden_file',
             'post-file.post.html']

  the_directory = DirDouble.new(entries)
  @dir = PostDir.new(the_directory)

  test 'directory entries are only post files' do
    assert_equal @dir.entries, ['post-file.post.html']
  end
end
