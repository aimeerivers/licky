require 'lib/webserver'
require 'test/test_helper'
require 'uri'
require 'net/http'

class WebserverTest
  include TestHelper

  def initialize
    @pages_directory = 'test_pages'
    @page_factory = PageFactory.new(PageFilePersistor.new(@pages_directory))
    @port = 8081
    @server = Webserver.new(@port, @page_factory)
    Thread.new { @server.start }
  end

  def create_page(title, content)
    page = @page_factory.find_or_create(title)
    page.content = content
    @page_factory.save_page(page)
    page
  end

  def finding_a_static_page
    response = get '/helloworld'
    assert_contains(response.body, '<h1>Hello world</h1>')
  end

  def parsing_page_title
    assert_equal(Webserver.parse_title('/Test_page'), 'Test page')
  end

  def parsing_a_complex_page_title
    assert_equal(Webserver.parse_title('/Ha_ha__/ha 24?! yay'), 'Ha ha ha 24 yay')
  end

  def removing_excess_whitespace_from_the_end_of_the_title
    assert_equal(Webserver.parse_title('/aimee/ '), 'aimee')
  end

  def displaying_title_on_the_page
    response = get '/Test_page'
    assert_contains(response.body, '<title>Test page</title>')
    assert_contains(response.body, 'Test page')
  end

  def displaying_content_for_existing_page
    page = create_page('Monday', "Monday's child is fair of face")
    response = get '/Monday'
    assert_contains(response.body, page.content)
  end

  def existing_page_shows_an_edit_link
    page = create_page('Wednesday', "Wednesday's child is full of woe")
    response = get '/Wednesday'
    assert_contains(response.body, %{<a href="/edit/Wednesday">Edit this page</a>})
  end

  def showing_a_page_that_does_not_exist_yet
    response = get '/Nonexistent'
    assert_contains(response.body, "This page does not exist. You can create it now.")
  end

  def showing_a_form_to_create_a_page
    response = get '/Nonexistent'
    assert_contains(response.body, "<form")
    assert_contains(response.body, "<textarea")
    assert_contains(response.body, "<input")
  end

  def creating_a_page
    post '/New_page', 'content' => 'CAN HAZ NEW PAGE PLZ'
    response = get '/New_page'
    assert_contains(response.body, "New page")
    assert_contains(response.body, "CAN HAZ NEW PAGE PLZ")
  end

  def editing_existing_page
    page = create_page('Tuesday', "Tuesday's child is full of grace")
    response = get '/edit/Tuesday'
    assert_contains(response.body, '<title>Edit Tuesday</title>')
    assert_contains(response.body, "<form")
    assert_contains(response.body, "<textarea")
    assert_contains(response.body, page.content)
    assert_contains(response.body, "<input")
  end

  def cancel_link_when_editing_a_page
    page = create_page('Friday', "Friday's child is good and gay")
    response = get '/edit/Friday'
    assert_contains(response.body, "<a href='/Friday'>Cancel</a>")
  end

  def home_page_can_be_displayed
    page = create_page('Home page', "This is the home page")
    response = get '/'
    assert_contains(response.body, "Home page")
    assert_contains(response.body, page.content)
    assert_contains(response.body, %{<a href="/edit/Home_page">Edit this page</a>})
  end

  def home_page_can_be_edited
    page = create_page('Home page', "This is the home page")
    response = get '/edit'
    assert_contains(response.body, "Edit Home page")
    assert_contains(response.body, "<form")
    assert_contains(response.body, "<textarea")
    assert_contains(response.body, page.content)
  end

  def converting_newlines_to_new_paragraphs
    page = create_page("newlines", "Line one\r\n\r\nLine two")
    response = get '/newlines'
    assert_contains(response.body, "<p>Line one</p><p>Line two</p>")
  end

  def tear_down
    print 'cleaning up after webserver tests ... '

    @server.stop

    Dir.entries(@pages_directory).each do |filename|
      File.delete(File.join(@pages_directory, filename)) if filename.length > 2
    end
    Dir.delete(@pages_directory)

    puts 'finished'
  end

  private

  def get(resource)
    url = URI.parse("http://localhost:#{@port}#{resource}")
    request = Net::HTTP::Get.new(url.path)
    content = Net::HTTP.start(url.host, url.port) do |http|
      http.request(request)
    end
  end

  def post(resource, params)
    url = URI.parse("http://localhost:#{@port}#{resource}")
    content = Net::HTTP.post_form(url, params)
  end

end
