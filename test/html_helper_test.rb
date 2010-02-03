require 'lib/html_helper'
require 'test/test_helper'

class HtmlHelperTest
  include TestHelper

  def converting_newlines_to_paragraphs
    result = HtmlHelper.to_html("line one\r\n\r\nline two\r\n\r\nline three")
    assert_equal(result, "line one</p><p>line two</p><p>line three")
  end

end
