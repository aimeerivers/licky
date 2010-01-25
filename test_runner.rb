Dir[File.dirname(__FILE__) + '/test/*.rb'].each {|file| require file }

test = PageTest.new
test.creating_a_new_page_using_the_factory
test.page_has_no_content_to_start_with
test.page_can_be_given_content

test = PageFilePersistorTest.new
test.figuring_out_filename_with_just_one_word
test.figuring_out_filename_with_more_than_one_word
test.figuring_out_filename_with_more_than_one_space

test = PageFactoryTest.new
test.saving_a_page_and_retrieving_it_again
test.saving_multiple_pages
test.page_is_created_in_the_file_system
test.page_content_is_written_to_the_file
test.page_content_is_read_from_the_file
test.tear_down

test = WebserverTest.new
test.finding_a_static_page
test.tear_down
