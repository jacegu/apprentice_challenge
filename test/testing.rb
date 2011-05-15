GREEN    = "\e[0;32m"
RED      = "\e[0;31m"
NO_COLOR = "\e[0m"

def assert_equal(a, b)
  raise "[#{a}] should be equal to [#{b}]" if a != b
end

def print_in_color(color, message)
  STDERR.puts "#{color}#{message}#{NO_COLOR}"
end

def test(message, &code_under_test)
  begin
    code_under_test.call
    print_in_color GREEN, ". #{message}"
  rescue Exception => error
    print_in_color RED, "F #{message}:\n    #{error}"
  end
end

if ARGV[0] == "testit"
  test 'assert equal works with equal elements' do
    assert_equal 'string', 'string'
  end

  test 'assert equal works with different elements' do
    assert_equal 'string', 'not string'
  end

  test 'test works when there are errors in the code under test' do
    infinite = 1 / 0
  end
end
