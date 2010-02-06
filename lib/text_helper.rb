module TextHelper

  def self.underscore(text)
    text.strip.gsub(/\s+/, '_')
  end

end
