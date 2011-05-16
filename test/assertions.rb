def assert_equal(a, b)
  raise ">#{a}< should be equal to >#{b}<" if a != b
end

def assert_not_equal(a, b)
  raise ">#{a}< should not be equal to >#{b}<" if a == b
end

def assert_true(expression)
  raise "it should be true" unless expression
end

def assert_false(expression)
  raise "it should be false" if expression
end

def assert_contains(actual_content, expected_content)
  unless actual_content.include?(expected_content)
    raise ">#{actual_content}< should contain >#{expected_content}<"
  end
end

def assert_does_not_contain(actual_content, rejected_content)
  if actual_content.include?(rejected_content)
    raise ">#{actual_content}< should not contain >#{rejected_content}<"
  end
end
