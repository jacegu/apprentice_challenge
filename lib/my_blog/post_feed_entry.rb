module MyBlog
  class PostFeedEntry
    SUMMARY_FOR_ENTRIES_WITHOUT_IT = ''

    attr_reader :title

    def initialize(entry)
      @title = entry.title
      @summary = entry.summary if entry.respond_to?(:summary)
      @updated_on = entry.updated
    end

    def description
      @summary || SUMMARY_FOR_ENTRIES_WITHOUT_IT
    end

    def publication_time
      @updated_on
    end
  end
end
