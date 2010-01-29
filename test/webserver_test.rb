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

  def tear_down
    print 'cleaning up after webserver tests ... '
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
