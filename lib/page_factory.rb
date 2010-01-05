require 'lib/page'
require 'lib/page_file_persistor'

class PageFactory

  def initialize(persistor=PageFilePersistor.new('pages'))
    @persistor = persistor
  end

  def find_or_create(title)
    Page.new(title, @persistor.find_or_create(title))
  end

  def save_page(page)
    @persistor.save_page(page)
  end

end
