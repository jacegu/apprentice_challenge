$: << File.join(File.expand_path(File.dirname(__FILE__)), '..')

require 'test_helper'
require 'file_double'

class DirDouble
  attr_reader :path, :entries

  def initialize(entries, path)
    @path = path
    @entries = entries
    @entries << '.'
    @entries << '..'
  end
end

module MyBlog
  entries = ['regular_file.txt',
             '.hidden_file',
             'post-file.post.html',
             'not-a-a-post-file.post.html.swp']

  the_directory = DirDouble.new(entries, '/')
  @dir = PostDir.new(the_directory)

  test 'directory has a path' do
    assert_equal @dir.path , '/'
  end

  test 'directory entries are only post files' do
    assert_equal @dir.entries, ['post-file.post.html']
  end

  test '#posts - return a post file for each post in the directory' do
    publication_time = DateTime.parse('2011-01-01 10:00')
    expected_post = Post.new('title', 'desc', 'content', publication_time)

    file = FileDouble.new("2011-01-01 10:00\ntitle\ndesc\ncontent")
    #File.yield_file_when_opening(file, '/post-file.post.html')

    assert_equal PostFile.new(file), expected_post
    #assert_true @dir.posts.include?(expected_post)
  end
end
