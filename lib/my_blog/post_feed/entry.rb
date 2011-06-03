module MyBlog
  module PostFeed
    class Entry < Post
      SUMMARY_FOR_ENTRIES_WITHOUT_IT = ''
      CONTENT_FOR_ENTRIES_WITHOUT_IT = ''

      def initialize(entry)
        @entry = entry
      end

      def title
        @entry.title.content
      end

      def description
        if has_summary?
          @entry.summary.content
        else
          SUMMARY_FOR_ENTRIES_WITHOUT_IT
        end
      end

      def content
        if has_content?
          @entry.content.content
        else
          CONTENT_FOR_ENTRIES_WITHOUT_IT
        end
      end

      def publication_time
        @entry.updated.content.to_datetime
      end

      def has_summary?
        @entry.respond_to?(:summary) and @entry.summary
      end

      def has_content?
        @entry.respond_to?(:content)
      end
    end
  end
end
