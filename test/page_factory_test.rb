require 'lib/page_factory'
require 'test/test_helper'

class PageFactoryTest
  include TestHelper

  def figuring_out_filename_with_just_one_word
    filename = PageFactory.filename_for('First')
    assert_equal(filename, 'First.txt')
  end

  def figuring_out_filename_with_more_than_one_word
    filename = PageFactory.filename_for('Two Words')
    assert_equal(filename, 'Two_Words.txt')
  end

  def figuring_out_filename_with_more_than_one_space
    filename = PageFactory.filename_for('Three Little     Words')
    assert_equal(filename, 'Three_Little_Words.txt')
  end

  def saving_a_page_and_retrieving_it_again
    page = PageFactory.find_or_create('Nice Day')
    page.content = 'Today is a lovely day'
    PageFactory.save_page(page)
    page = PageFactory.find_or_create('Nice Day')
    assert_equal(page.content, 'Today is a lovely day')
  end

  def saving_multiple_pages
    page = PageFactory.find_or_create('Monday')
    page.content = "Monday's child is fair of face"
    PageFactory.save_page(page)

    page = PageFactory.find_or_create('Tuesday')
    page.content = "Tuesday's child is full of grace"
    PageFactory.save_page(page)

    page = PageFactory.find_or_create('Monday')
    assert_equal(page.content, "Monday's child is fair of face")

    page = PageFactory.find_or_create('Tuesday')
    assert_equal(page.content, "Tuesday's child is full of grace")
  end

  def page_is_saved_to_the_file_system
    delete_file('pages/Filesystem.txt')
    page = PageFactory.find_or_create('Filesystem')
    PageFactory.save_page(page)
    assert_true(File.exists?('pages/Filesystem.txt'))
  end

  private

  def delete_file(filename)
    File.delete(filename) if File.exist?(filename)
  end
end
