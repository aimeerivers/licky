require 'lib/page'
require 'test/test_helper'

class PageTest
  include TestHelper

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
