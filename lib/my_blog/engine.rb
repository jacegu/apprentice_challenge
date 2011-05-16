$: << File.join(File.expand_path(File.dirname(__FILE__)), "..", "..", "lib")

require 'my_blog'

module MyBlog
  class Engine
    class Request
      attr_reader :uri

      def initialize(uri)
        @uri = uri
      end

      def post_uri
        @uri.sub(/^\/blog\//, '')
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
