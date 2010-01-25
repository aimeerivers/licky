module TestHelper
  def assert_equal(actual, expected)
    puts result = (actual == expected)
    if !result
      puts "Expected ---> #{expected}"
      puts "Received ---> #{actual}"
    end
  end

  def assert_true(assertion)
    assert_equal(assertion, true)
  end

  def assert_contains(content, expected)
    puts result = (content.include?(expected))
    if !result
      puts "Received ---> #{content}"
      puts "Expected to contain ---> #{expected}"
      puts "But did not"
    end
  end
  
end
