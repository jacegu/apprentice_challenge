class FeedDouble
  def initialize(content)
    @content = content
  end

  def read
    @content
  end

  def rewind
    @rewinded = true
  end

  def rewinded?
    @rewinded || false
  end
end
