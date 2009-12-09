class Page
  attr_reader :title

  def initialize(title)
    @title = title
  end

end

class PageTest

  def assert_equal(first, second)
    puts first == second
  end

  def creating_a_new_page
    p = Page.new('O HAI')
    assert_equal(p.title, 'O HAI')
  end
end

test = PageTest.new
test.creating_a_new_page
