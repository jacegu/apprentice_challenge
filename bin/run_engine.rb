#!/usr/bin/env ruby

$: << File.join(File.expand_path(File.dirname(__FILE__)), '..', 'lib')

require 'my_blog'
require 'open-uri'

default_port     = 8583
blog_name        = '@ecomba apprentice challenge blog'
blog_description = 'This blog engine uses only The Ruby Language core and has been created as an answer to the challenge that Enrique Comba threw to anyone who wanted to be his apprentice.'

#feed_uri = 'http://ecomba.org/blog/rss'
#feed_uri = 'http://javieracero.com/blog/rss'
#feed_uri = 'http://feeds.feedburner.com/SeHaceCaminoAlAndar?format.xml'
feed_uri = 'http://www.carlosble.com/feed/'

feed = MyBlog::PostFeed.new(open(feed_uri))
blog = MyBlog::Blog.new(blog_name, blog_description, feed)
MyBlog::Engine.new(default_port, blog).start
