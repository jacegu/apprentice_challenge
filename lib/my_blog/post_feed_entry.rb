module MyBlog
  class PostFeedEntry < Post
    SUMMARY_FOR_ENTRIES_WITHOUT_IT = ''
    CONTENT_FOR_ENTRIES_WITHOUT_IT = ''

    attr_reader :title

    def initialize(entry)
      @title = entry.title.content
      @summary = entry.summary.content if entry.respond_to?(:summary)
      @content = entry.content.content if entry.respond_to?(:content)
      @updated_on = entry.updated.content
    end

    def description
      @summary || SUMMARY_FOR_ENTRIES_WITHOUT_IT
    end

    def content
      @content || CONTENT_FOR_ENTRIES_WITHOUT_IT
    end

    def publication_time
      @updated_on.to_datetime
    end
  end
end
