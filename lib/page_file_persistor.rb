class PageFilePersistor

  def initialize(pages_directory)
    @pages_directory = pages_directory
    Dir.mkdir(@pages_directory) unless File.directory?(@pages_directory)
  end

  def find_or_create(title)
    filename = filename_for(title)
    File.read("#{@pages_directory}/#{filename}") if File.exists?("#{@pages_directory}/#{filename}")
  end

  def save_page(page)
    filename = filename_for(page.title)
    File.open("#{@pages_directory}/#{filename}", 'w') do |f|
      f.write(page.content)
    end
  end

  def filename_for(title)
    title.gsub(/\s+/, '_') + '.txt'
  end

end
