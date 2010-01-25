require 'lib/webserver'
require 'test/test_helper'
require 'uri'
require 'net/http'

class WebserverTest
  include TestHelper

  def initialize
    @port = 8080
    @server = Webserver.new(@port)
    Thread.new { @server.start }
  end

  def finding_a_static_page
    response = get '/helloworld'
    assert_contains(response.body, '<h1>Hello world</h1>')
  end

  def tear_down
    @server.stop
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
