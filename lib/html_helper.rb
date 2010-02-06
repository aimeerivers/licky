module HtmlHelper

  SUBSTITUTIONS = [
    ['<', '&lt;'],
    ['>', '&gt;'],
    ["\r\n\r\n","</p><p>"]
  ]

  def self.to_html(text)
    result = text.clone
    SUBSTITUTIONS.each do |substitution|
      result.gsub!(substitution[0], substitution[1])
    end
    result
  end

end
