class Page
  attr_reader :title
  attr_accessor :content

  def initialize(title, content=nil)
    @title = title
    @content = content
  end

end
