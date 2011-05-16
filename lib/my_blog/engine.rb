$: << File.join(File.expand_path(File.dirname(__FILE__)), "..", "..", "lib")

require 'my_blog'
require 'webrick'
require 'erb'

module MyBlog
  POSTS_DIR = 'posts'
  VIEWS_DIR = 'views'

  class Engine
    include WEBrick

    def initialize(port, blog)
      @blog = blog
      @server = WEBrick::HTTPServer.new(:Port => port)
      @server.mount('/blog', BlogServlet, @blog)
      trap("INT"){ @server.shutdown }
    end

    def start
      @server.start
    end

    def stop
      @server.stop
    end

    module Renderer
      def render(view)
        html = ""
        File.open("#{VIEWS_DIR}/#{view}.html.erb", 'r'){ |f| html = f.read }
        ERB.new(html).result(binding)
      end
    end

    class BlogServlet < HTTPServlet::AbstractServlet
      include Renderer

      def do_GET(request, response)
        @blog = @options[0]
        blog_request = Request.new(request.path)
        render_main_page(response) if blog_request.main_page?
        render_post_page(blog_request.post_uri, response) if blog_request.post_page?
      end

      def render_main_page(response)
        response['status'] = 200
        response['Content-Type'] = 'text/html'
        response.body = render :blog
      end

      def render_post_page(post_uri, response)
        @post = @blog.post_with_uri(post_uri)
        if @post.found?
          response['status'] = 200
          response['Content-Type'] = 'text/html'
          response.body = render :post
        else
          not_found
        end
      end

      def not_found
        raise WEBrick::HTTPStatus::NotFound
      end
    end

    class Request
      attr_reader :uri

      def initialize(uri)
        @uri = uri
      end

      def post_uri
        return @uri.sub(/^\/blog\//, '') if post_page?
        ''
      end

      def main_page?
        @uri == '/blog' or @uri == '/blog/'
      end

      def post_page?
        @uri =~ /\/blog\/[\w|-]+$/
      end
    end
  end
end
