require './test_helper'

class StringEncryptorTest < Minitest::Test
  attr_reader :encryptor
  
  def setup
    sample_string = "Hello. This is not encrypted."
    @encryptor = StringEncryptor.new(sample_string)
  end
  
  def test_it_prepares_string
    expected = ["h", "e", "l", "l", "o", ".",
                " ", "t", "h", "i", "s", " ",
                "i", "s", " ", "n", "o", "t",
                " ", "e", "n", "c", "r", "y",
                "p", "t", "e", "d", "."] 
    actual = encryptor.prepare_string
    
    assert_equal expected, actual
  end
  
  def test_it_converts_string_to_array

  end
  
end
