require 'lib/text_helper'
require 'test/test_helper'

class TextHelperTest
  include TestHelper

  def turning_spaces_to_underscores
    assert_equal(TextHelper.underscore('one'), 'one')
    assert_equal(TextHelper.underscore('one two'), 'one_two')
    assert_equal(TextHelper.underscore(' one two    three '), 'one_two_three')
  end

end
