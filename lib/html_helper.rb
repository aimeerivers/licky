module HtmlHelper

  def self.to_html(text)
    text.gsub("\r\n\r\n", "</p><p>")
  end

end
