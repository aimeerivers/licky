require 'webrick'

class Webserver
  include WEBrick

  class HelloWorldServlet < HTTPServlet::AbstractServlet
    def do_GET(request, response)
      response.body = %Q{
        <html><body>
          <h1>Hello world</h1>
        </body></html>
      }
      response['Content-Type'] = 'text/html'
    end
  end

  class WikiPageServlet < HTTPServlet::AbstractServlet
    def do_GET(request, response)
      page_title = Webserver.parse_title(request.path_info)
      page_factory = PageFactory.new(PageFilePersistor.new('test_pages'))
      page = page_factory.find_or_create(page_title)
      response.body = %Q{
        <html><body>
          <h1>#{page_title}</h1>
          <p>#{page.content}</p>
        </body></html>
      }
      response['Content-Type'] = 'text/html'
    end
  end

  def initialize(port_number)
    @server = WEBrick::HTTPServer.new(:Port => port_number)
    @server.mount('/helloworld', HelloWorldServlet)
    @server.mount('/', WikiPageServlet)
    trap('INT') { stop }
  end

  def start
    @server.start
  end

  def stop
    @server.shutdown
  end
  
  def self.parse_title(title)
    title.sub('/', '').gsub(/[^\da-zA-Z]+/, ' ')
  end

end
