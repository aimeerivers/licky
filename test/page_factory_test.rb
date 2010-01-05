require 'lib/page_factory'
require 'test/test_helper'

class PageFactoryTest
  include TestHelper
  
  def initialize
    @page_factory = PageFactory.new
  end

  def figuring_out_filename_with_just_one_word
    filename = @page_factory.filename_for('First')
    assert_equal(filename, 'First.txt')
  end

  def figuring_out_filename_with_more_than_one_word
    filename = @page_factory.filename_for('Two Words')
    assert_equal(filename, 'Two_Words.txt')
  end

  def figuring_out_filename_with_more_than_one_space
    filename = @page_factory.filename_for('Three Little     Words')
    assert_equal(filename, 'Three_Little_Words.txt')
  end

  def saving_a_page_and_retrieving_it_again
    page = @page_factory.find_or_create('Nice Day')
    page.content = 'Today is a lovely day'
    @page_factory.save_page(page)
    page = @page_factory.find_or_create('Nice Day')
    assert_equal(page.content, 'Today is a lovely day')
  end

  def saving_multiple_pages
    page = @page_factory.find_or_create('Monday')
    page.content = "Monday's child is fair of face"
    @page_factory.save_page(page)

    page = @page_factory.find_or_create('Tuesday')
    page.content = "Tuesday's child is full of grace"
    @page_factory.save_page(page)

    page = @page_factory.find_or_create('Monday')
    assert_equal(page.content, "Monday's child is fair of face")

    page = @page_factory.find_or_create('Tuesday')
    assert_equal(page.content, "Tuesday's child is full of grace")
  end

  def page_is_created_in_the_file_system
    delete_file('pages/Filesystem.txt')
    page = @page_factory.find_or_create('Filesystem')
    @page_factory.save_page(page)
    assert_true(File.exists?('pages/Filesystem.txt'))
  end

  def page_content_is_written_to_the_file
    delete_file('pages/File_contents.txt')
    page = @page_factory.find_or_create('File contents')
    page.content = 'Woohoo'
    @page_factory.save_page(page)
    File.open('pages/File_contents.txt', 'r') do |f|
      assert_equal(f.read, 'Woohoo')
    end
  end

  def page_content_is_read_from_the_file
    delete_file('pages/Ruby_Docs.txt')
    File.open('pages/Ruby_Docs.txt', 'w') do |f|
      f.write('Cool stuff contained here')
    end
    page = @page_factory.find_or_create('Ruby Docs')
    assert_equal(page.content, 'Cool stuff contained here')
  end

  private

  def delete_file(filename)
    File.delete(filename) if File.exist?(filename)
  end
end
