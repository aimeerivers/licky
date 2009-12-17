require 'lib/page'

class PageFactory
  @@pages = {}

  def self.find_or_create(title)
    page_content = @@pages[filename_for(title)]
    Page.new(title, page_content)
  end

  def self.save_page(page)
    @@pages[filename_for(page.title)] = page.content
  end

  def self.filename_for(title)
    title.gsub(/\s+/, '_') + '.txt'
  end
end
