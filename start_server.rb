Dir[File.dirname(__FILE__) + '/lib/*.rb'].each {|file| require file }

Webserver.new(8080).start
