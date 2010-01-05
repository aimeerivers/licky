require 'lib/page_file_persistor'
require 'test/test_helper'

class PageFilePersistorTest
  include TestHelper

  def initialize
    @persistor = PageFilePersistor.new('test_pages')
  end
  
  def figuring_out_filename_with_just_one_word
    filename = @persistor.filename_for('First')
    assert_equal(filename, 'First.txt')
  end

  def figuring_out_filename_with_more_than_one_word
    filename = @persistor.filename_for('Two Words')
    assert_equal(filename, 'Two_Words.txt')
  end

  def figuring_out_filename_with_more_than_one_space
    filename = @persistor.filename_for('Three Little     Words')
    assert_equal(filename, 'Three_Little_Words.txt')
  end
end
