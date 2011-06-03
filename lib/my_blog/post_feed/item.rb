module MyBlog
  module PostFeed
    class Item < Post

      DESCRIPTION_FOR_ITEM_WITHOUT_CONTENT = ''

      attr_reader :title

      def initialize(item)
        @title = item.title
        @description = item.description
        @content = item.content_encoded if item.respond_to?(:content_encoded)
        @publication_time = item.pubDate.to_datetime if item.respond_to?(:pubDate)
      end

      def description
        if @content
          @description
        else
          DESCRIPTION_FOR_ITEM_WITHOUT_CONTENT
        end
      end

      def content
        @content || @description
      end

      def publication_time
        @publication_time || DateTime.now
      end
    end
  end
end
