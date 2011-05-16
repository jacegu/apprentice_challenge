$: << File.join(File.expand_path(File.dirname(__FILE__)), '..', 'test')

require 'assertions'

GREEN    = "\e[0;32m"
RED      = "\e[0;31m"
YELLOW   = "\e[0;33m"
NO_COLOR = "\e[0m"

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

def xtest(message, &code_under_test)
  print_in_color YELLOW, "P pending: #{message}"
end


if ARGV[0] == "testit"
  test 'assert equal works with equal elements' do
    assert_equal 'string', 'string'
  end

  test 'assert equal works with different elements' do
    assert_equal 'string', 'not string'
  end

  test 'assert not equal works with not equal elements' do
    assert_not_equal 2, 4
  end

  test 'assert not equal works with equal elements' do
    assert_not_equal :symbol, :symbol
  end

  test 'assert true works with expressions that evaluate to true' do
    assert_true 'a' == 'a'
  end

  test 'assert false works with expressions that evaluate to false' do
    assert_false false
  end

  test 'assert false works with expressions that evaluate to false' do
    assert_false true
  end

  test 'assert contains works with contained text' do
    assert_contains 'abcd', 'a'
  end

  test 'assert contains works with not contained text' do
    assert_contains 'abcd', 'e'
  end

  test 'assert does not contain works with rejected text' do
    assert_does_not_contain 'abcd', 'e'
  end

  test 'assert does not contains works with contained text' do
    assert_does_not_contain 'abcd', 'a'
  end

  test 'test works when there are errors in the code under test' do
    infinite = 1 / 0
  end

  xtest 'this is pending' do
    "nothing"
  end
end
