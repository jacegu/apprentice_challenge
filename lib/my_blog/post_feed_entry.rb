module MyBlog
  class PostFeedEntry
    SUMMARY_FOR_ENTRIES_WITHOUT_IT = ''

    attr_reader :title

    def initialize(entry)
      @title = entry.title
      @summary = entry.summary if entry.respond_to?(:summary)
    end

    def description
      @summary || SUMMARY_FOR_ENTRIES_WITHOUT_IT
    end
  end
end
