GREEN    = "\e[0;32m"
RED      = "\e[0;31m"
NO_COLOR = "\e[0m"

def assert_equal(a, b)
  raise "[#{a} != #{b}]" if a != b
end

def test(message, &code_under_test)
  begin
    code_under_test.call
    puts "#{GREEN}. #{message}#{NO_COLOR}"
  rescue Exception => error_message
    puts "#{RED}F #{message}: #{error_message}#{NO_COLOR}"
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
