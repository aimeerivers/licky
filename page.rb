class Page
  attr_reader :title
  attr_accessor :content

  def initialize(title)
    @title = title
  end

end

class PageTest

  def assert_equal(actual, expected)
    puts actual == expected
  end

  def creating_a_new_page
    p = Page.new('O HAI')
    assert_equal(p.title, 'O HAI')
  end

  def page_has_content
    p = Page.new('With Content')
    p.content = 'Lorem ipsum'
    assert_equal(p.content, 'Lorem ipsum')
  end
end

test = PageTest.new
test.creating_a_new_page
test.page_has_content
