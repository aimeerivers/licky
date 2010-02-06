Dir[File.dirname(__FILE__) + '/test/*.rb'].each {|file| require file }

test = PageTest.new
test.creating_a_new_page_using_the_factory
test.page_has_no_content_to_start_with
test.page_with_no_content_is_considered_a_new_page
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

test = HtmlHelperTest.new
test.converting_newlines_to_paragraphs
test.sanitising_html
test.parsing_ampersand_characters

test = WebserverTest.new
test.finding_a_static_page
test.parsing_page_title
test.parsing_a_complex_page_title
test.removing_excess_whitespace_from_the_end_of_the_title
test.displaying_title_on_the_page
test.displaying_content_for_existing_page
test.existing_page_shows_an_edit_link
test.showing_a_page_that_does_not_exist_yet
test.showing_a_form_to_create_a_page
test.creating_a_page
test.editing_existing_page
test.home_page_can_be_displayed
test.home_page_can_be_edited
test.converting_newlines_to_new_paragraphs
test.tear_down
