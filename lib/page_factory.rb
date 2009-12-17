require 'lib/page'

class PageFactory
  @@pages = {}

  def self.find_or_create(title)
    filename = filename_for(title)
    page_content = File.read("pages/#{filename}") if File.exists?("pages/#{filename}")
    Page.new(title, page_content)
  end

  def self.save_page(page)
    filename = filename_for(page.title)
    @@pages[filename] = page.content
    File.open("pages/#{filename}", 'w') do |f|
      f.write(page.content)
    end
  end

  def self.filename_for(title)
    title.gsub(/\s+/, '_') + '.txt'
  end
end
