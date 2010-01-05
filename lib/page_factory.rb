require 'lib/page'

class PageFactory

  def find_or_create(title)
    filename = filename_for(title)
    page_content = File.read("pages/#{filename}") if File.exists?("pages/#{filename}")
    Page.new(title, page_content)
  end

  def save_page(page)
    filename = filename_for(page.title)
    File.open("pages/#{filename}", 'w') do |f|
      f.write(page.content)
    end
  end

  def filename_for(title)
    title.gsub(/\s+/, '_') + '.txt'
  end
end
