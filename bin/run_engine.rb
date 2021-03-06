#!/usr/bin/env ruby

$: << File.join(File.expand_path(File.dirname(__FILE__)), '..', 'lib')

require 'my_blog'

default_port     = 8583
blog_name        = '@ecomba apprentice challenge blog'
blog_description = 'This blog engine uses only The Ruby Language core and has been created as an answer to the challenge that Enrique Comba threw to anyone who wanted to be his apprentice.'

dir = MyBlog::PostDir.new(Dir.open(MyBlog::POSTS_DIR))
blog = MyBlog::Blog.new(blog_name, blog_description, dir)
MyBlog::Engine.new(default_port, blog).start
