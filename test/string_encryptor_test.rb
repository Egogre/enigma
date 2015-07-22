require './test/test_helper'

class StringEncryptorTest < Minitest::Test
  attr_reader :encryptor, :sample_string
  
  def setup
    @sample_string = "Hello. This is not encrypted."
    rotations = {:A_rotation => 12, :B_rotation => 23, :C_rotation => 34, :D_rotation => 45}
    offsets = {:A_offset => 1, :B_offset => 2, :C_offset => 3, :D_offset => 4}
    @encryptor = StringEncryptor.new(sample_string, rotations, offsets)
  end
  
  def test_it_prepares_string
    expected = ["H", "e", "l", "l", "o", ".",
                " ", "T", "h", "i", "s", " ",
                "i", "s", " ", "n", "o", "t",
                " ", "e", "n", "c", "r", "y",
                "p", "t", "e", "d", "."] 
    actual = encryptor.prepared_string
    
    assert_equal expected, actual
  end
  
  def test_it_calculates_encrypt_shift
    offset = 4
    rotation = 34
    character = 'c'
    
    expected = 'A'
    actual = encryptor.character_shift(character, rotation, offset)
    
    assert_equal expected, actual
  end
  
  def test_it_encrypts_string 
    # skip   
    expected = "U3IU1WhCu7PtvDhW1EhN01Oh2EBMK"
    actual = encryptor.encrypt_string
    
    assert_equal expected, actual
    
    assert_equal sample_string.length, encryptor.encrypt_string.length
  end
  
end
