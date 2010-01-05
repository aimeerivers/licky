require 'lib/page_factory'
require 'test/test_helper'

class PageFactoryTest
  include TestHelper
  
  def initialize
    @pages_directory = 'test_pages'
    @page_factory = PageFactory.new(PageFilePersistor.new(@pages_directory))
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
    page = @page_factory.find_or_create('Filesystem')
    @page_factory.save_page(page)
    assert_true(File.exists?(@pages_directory + '/Filesystem.txt'))
  end

  def page_content_is_written_to_the_file
    page = @page_factory.find_or_create('File contents')
    page.content = 'Woohoo'
    @page_factory.save_page(page)
    File.open(@pages_directory + '/File_contents.txt', 'r') do |f|
      assert_equal(f.read, 'Woohoo')
    end
  end

  def page_content_is_read_from_the_file
    File.open(@pages_directory + '/Ruby_Docs.txt', 'w') do |f|
      f.write('Cool stuff contained here')
    end
    page = @page_factory.find_or_create('Ruby Docs')
    assert_equal(page.content, 'Cool stuff contained here')
  end

  def tear_down
    print 'cleaning up after page factory tests ... '
    Dir.entries(@pages_directory).each do |filename|
      File.delete(File.join(@pages_directory, filename)) if filename.length > 2
    end
    Dir.delete(@pages_directory)
    puts 'finished'
  end
end
