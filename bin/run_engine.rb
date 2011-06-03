#!/usr/bin/env ruby

$: << File.join(File.expand_path(File.dirname(__FILE__)), '..', 'lib')

require 'my_blog'
require 'open-uri'

default_port     = 8583
blog_name        = '@ecomba apprentice challenge blog'
blog_description = 'This blog engine uses only The Ruby Language core and has been created as an answer to the challenge that Enrique Comba threw to anyone who wanted to be his apprentice.'

# RSS
#feed_uri = 'http://feeds.feedburner.com/SeHaceCaminoAlAndar?format.xml'
#feed_uri = 'http://www.carlosble.com/feed/'
#feed_uri = 'http://feeds2.feedburner.com/CoreysPairProgrammingTour'
#feed_uri = 'http://blog.rubybestpractices.com/feed/gregory.xml'
#feed_uri = 'http://sermoa.wordpress.com/feed'
#feed_uri = 'http://feeds.feedburner.com/obtiva'
feed_uri = 'http://www.tuaw.com/rss.xml'

#feed_uri = 'http://ecomba.org/blog/rss'

# Atom
#feed_uri = 'http://feeds.feedburner.com/YoYElSoftware?format=xml'
#feed_uri = 'http://pragdave.blogs.pragprog.com/pragdave/atom.xml'
#feed_uri = 'http://martinfowler.com/feed.atom'
#feed_uri = 'http://feeds.feedburner.com/RidingRails'
#feed_uri = 'http://thecleancoder.blogspot.com/feeds/posts/default'
#feed_uri = 'http://blog.8thlight.com/feed/atom.xml'
#feed_uri = 'http://chadfowler.com/posts.atom'

feed = MyBlog::Feed.new(feed_uri)
blog = MyBlog::Blog.new(blog_name, blog_description, feed.make_post_feed)
MyBlog::Engine.new(default_port, blog).start
