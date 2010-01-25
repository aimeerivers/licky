require 'webrick'

class Webserver
  include WEBrick
  

  def initialize(port_number)
    helloworld = lambda do |request, response|
      response['Content-Type'] = 'text/html'
      response.body = %{
        <html><body>
          <h1>Hello world</h1>
        </body></html>
      }
    end
    @server = WEBrick::HTTPServer.new(:Port => port_number)
    @server.mount('/helloworld', HTTPServlet::ProcHandler.new(helloworld))
    trap('INT') { stop }
  end

  def start
    @server.start
  end

  def stop
    @server.shutdown
  end

end
