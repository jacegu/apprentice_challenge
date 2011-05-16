$: << File.join(File.expand_path(File.dirname(__FILE__)), "..", "..", "lib")

require 'my_blog'
require 'webrick'

module MyBlog
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

    class BlogServlet < HTTPServlet::AbstractServlet
      def do_GET(request, response)
        @blog = @options[0]
        blog_request = Request.new(request.path)
        render_main_page(response) if blog_request.main_page?
        render_post_page(blog_request.post_uri, response) if blog_request.post_page?
      end

      def render_main_page(response)
        response['status'] = 200
        response['Content-Type'] = 'text/html'
        published_posts = ""
        @blog.published_posts.each do |post|
          published_posts << "<h1>#{post.title}</h1>\n"
        end
        response.body = %{
           <html>
           <head><title>#{@blog.name}</title></head>
           <body>#{published_posts}</body>
           </html>
        }
      end

      def render_post_page(post_uri, response)
        post = @blog.post_with_uri(post_uri)
        if post.found?
          response['status'] = 200
          response['Content-Type'] = 'text/html'
          response.body = %{
             <html>
             <head><title>#{post.title} | #{@blog.name}</title></head>
             <body>
               <h1>#{post.title}</h1>
               #{post.content}
             </body>
             </html>
          }
        else
          not_found
        end
      end

      def not_found
        raise HTTPStatus::NotFound
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
