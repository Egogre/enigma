require './test/test_helper'

class StringDecryptorTest < Minitest::Test
  attr_reader :decryptor, :sample_string
  
  def setup
    @sample_string = "U3IU8KV4Q25VFbQ0\nQty01Oh963Au"
    rotations = {:A_rotation => 12, :B_rotation => 23, :C_rotation => 34, :D_rotation => 45, :E_rotation => 15}
    offsets = {:A_offset => 1, :B_offset => 2, :C_offset => 3, :D_offset => 4, :E_offset => 5}
    @decryptor = StringDecryptor.new(sample_string, rotations, offsets)
  end
  
  def test_it_prepares_string
    expected = ["U", "3", "I", "U", "8", "K",
                "V", "4", "Q", "2", "5", "V",
                "F", "b", "Q", "0", "\n", "Q",
                "t", "y", "0", "1", "O", "h",
                "9", "6", "3", "A", "u"] 
    actual = decryptor.prepared_string
    
    assert_equal expected, actual
  end
  
  def test_it_calculates_decrypt_shift
    # skip
    offset = 4
    rotation = 34
    character = 'A'
    
    expected = 'c'
    actual = decryptor.character_shift(character, rotation, offset)
    
    assert_equal expected, actual
  end
  
  def test_it_encrypts_string 
    # skip   
    expected = "Hello. This is not encrypted."
    actual = decryptor.decrypt_string
    
    assert_equal expected, actual
    
    assert_equal sample_string.length, decryptor.decrypt_string.length
  end
  
end
