require 'lib/page'
require 'lib/page_factory'
require 'test/test_helper'

class PageTest
  include TestHelper

  def initialize
    @page_factory = PageFactory.new(PageFilePersistor.new('test_pages'))
  end

  def creating_a_new_page_using_the_factory
    p = @page_factory.find_or_create('O HAI')
    assert_equal(p.title, 'O HAI')
  end

  def page_has_no_content_to_start_with
    p = @page_factory.find_or_create('No Content')
    assert_equal(p.content, nil)
  end

  def page_with_no_content_is_considered_a_new_page
    p = @page_factory.find_or_create('No Content')
    assert_true(p.new_page?)
  end

  def page_can_be_given_content
    p = @page_factory.find_or_create('With Content')
    p.content = 'Lorem ipsum'
    assert_equal(p.content, 'Lorem ipsum')
  end
end
