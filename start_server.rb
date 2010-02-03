Dir[File.dirname(__FILE__) + '/lib/*.rb'].each {|file| require file }

page_factory = PageFactory.new(PageFilePersistor.new('pages'))
Webserver.new(8080, page_factory).start
