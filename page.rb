class Page
  attr_reader :title
  attr_accessor :content

  def initialize(title)
    @title = title
  end

end

class PageFactory
  def self.find_or_create(title)
    Page.new(title)
  end
end

class PageTest

  def assert_equal(actual, expected)
    puts actual == expected
  end

  def creating_a_new_page_using_the_factory
    p = PageFactory.find_or_create('O HAI')
    assert_equal(p.title, 'O HAI')
  end

  def page_has_no_content_to_start_with
    p = PageFactory.find_or_create('No Content')
    assert_equal(p.content, nil)
  end

  def page_can_be_given_content
    p = PageFactory.find_or_create('With Content')
    p.content = 'Lorem ipsum'
    assert_equal(p.content, 'Lorem ipsum')
  end
end

test = PageTest.new
test.creating_a_new_page_using_the_factory
test.page_has_no_content_to_start_with
test.page_can_be_given_content
