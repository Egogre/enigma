require './test/test_helper'

class KeyGeneratorTest < Minitest::Test
  
  def test_it_generates_a_random_key
    generator = KeyGenerator.new
    
    assert generator.key
  end
  
  def test_it_accepts_given_key
    generator = KeyGenerator.new(12345)
    
    expected = 12345
    actual = generator.key
    
    assert_equal expected, actual
  end
  
end
