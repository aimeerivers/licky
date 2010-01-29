require 'lib/webserver'
require 'test/test_helper'
require 'uri'
require 'net/http'

class WebserverTest
  include TestHelper

  def initialize
    @port = 8081
    @server = Webserver.new(@port)
    Thread.new { @server.start }

    @pages_directory = 'test_pages'
    @page_factory = PageFactory.new(PageFilePersistor.new(@pages_directory))
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

  def displaying_title_on_the_page
    response = get '/Test_page'
    assert_contains(response.body, 'Test page')
  end

  def displaying_content_for_existing_page
    page = @page_factory.find_or_create('Monday')
    page.content = "Monday's child is fair of face"
    @page_factory.save_page(page)
    response = get '/Monday'
    assert_contains(response.body, page.content)
  end

  def tear_down
    print 'cleaning up after webserver tests ... '

    Dir.entries(@pages_directory).each do |filename|
      File.delete(File.join(@pages_directory, filename)) if filename.length > 2
    end
    Dir.delete(@pages_directory)

    @server.stop
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

end
