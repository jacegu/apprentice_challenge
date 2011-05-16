$: << File.join(File.expand_path(File.dirname(__FILE__)), "..", "..", "lib")

require 'my_blog'
require 'webrick'
require 'erb'

module MyBlog
  POSTS_DIR  = 'posts'
  VIEWS_DIR  = 'views'
  PUBLIC_DIR = 'public'

  class Engine
    include WEBrick

    def initialize(port, blog)
      @blog = blog
      @server = WEBrick::HTTPServer.new(:Port => port, :DocumentRoot => PUBLIC_DIR)
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
        @request, @response = request, response
        @blog = @options[0]
        render_response
      end

      def render_response
        blog_request = Request.new(@request.path)
        render_main_page if blog_request.main_page?
        render_post_page(blog_request.post_uri) if blog_request.post_page?
      end

      def render_main_page
        render_page(:blog)
      end

      def render_post_page(post_uri)
        @post = @blog.post_with_uri(post_uri)
        if @post.found?
          render_page(:post)
        else
          not_found
        end
      end

      def render_page(page)
        @response.body = render page
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
