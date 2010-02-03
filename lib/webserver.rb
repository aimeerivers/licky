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

  class EditWikiPageServlet < HTTPServlet::AbstractServlet
    def do_GET(request, response)
      path = request.path_info.sub('/edit', '')
      path = '/Home_page' if path == '' || path == '/'
      page_title = Webserver.parse_title(path)
      page_factory = @options[0]
      page = page_factory.find_or_create(page_title)
      response.body = %{
        <html><body>
          <h1>Edit #{page_title}</h1>
          <form action="#{path}" method="POST">
            <textarea rows="30" cols="100" name="content">#{page.content}</textarea>
            <br />
            <input type="submit" value="Update page" />
          </form>
        </body></html>
      }
      response['Content-Type'] = 'text/html'
    end
  end

  class WikiPageServlet < HTTPServlet::AbstractServlet
    def do_GET(request, response)
      path = request.path_info
      path = '/Home_page' if path == '/'
      page_title = Webserver.parse_title(path)
      page_factory = @options[0]
      page = page_factory.find_or_create(page_title)
      response.body = %{
        <html><body>
          <h1>#{page_title}</h1>
      }
      
      if page.new_page?
        response.body += %{
          <p>This page does not exist. You can create it now.</p>
          <form action="#{path}" method="POST">
            <textarea rows="30" cols="100" name="content"></textarea>
            <br />
            <input type="submit" value="Create page" />
          </form>
        }
      else
        response.body += %{
          <p>#{page.content}</p>
          <p><a href="/edit#{path}">Edit this page</a></p>
        }
      end

      response.body += %{
        </body></html>
      }
      response['Content-Type'] = 'text/html'
    end

    def do_POST(request, response)
      page_title = Webserver.parse_title(request.path_info)
      page_factory = @options[0]
      page = page_factory.find_or_create(page_title)
      page.content = request.query['content']
      page_factory.save_page(page)
      response.set_redirect(WEBrick::HTTPStatus::Found, request.path_info)
    end
  end

  def initialize(port_number, page_factory)
    @server = WEBrick::HTTPServer.new(:Port => port_number)
    @server.mount('/helloworld', HelloWorldServlet)
    @server.mount('/edit/', EditWikiPageServlet, page_factory)
    @server.mount('/', WikiPageServlet, page_factory)
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
