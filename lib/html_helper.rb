require 'lib/text_helper'

module HtmlHelper

  SUBSTITUTIONS = [
    ['&', '&amp;'],
    ['<', '&lt;'],
    ['>', '&gt;'],
    ["\r\n\r\n","</p><p>"]
  ]

  def self.to_html(text)
    result = text.clone
    SUBSTITUTIONS.each do |substitution|
      result.gsub!(substitution[0], substitution[1])
    end

    result.gsub(/\[\[(.+)\]\]/) do
      "<a href='/#{TextHelper.underscore($1)}'>#{$1}</a>"
    end
  end

end
