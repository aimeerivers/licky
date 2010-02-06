require 'lib/html_helper'
require 'test/test_helper'

class HtmlHelperTest
  include TestHelper

  def converting_newlines_to_paragraphs
    result = parse("line one\r\n\r\nline two\r\n\r\nline three")
    assert_equal(result, "line one</p><p>line two</p><p>line three")
  end

  def sanitising_html
    result = parse("<script type='text/javascript'>alert('hi');</script>")
    assert_equal(result, "&lt;script type='text/javascript'&gt;alert('hi');&lt;/script&gt;")
  end

  def parsing_ampersand_characters
    result = parse("Jane & Michelle")
    assert_equal(result, "Jane &amp; Michelle")
  end

  def linking_to_other_wiki_pages
    assert_equal(parse('[[aimee]]'), "<a href='/aimee'>aimee</a>")
  end

  private

  def parse(text)
    HtmlHelper.to_html(text)
  end

end
