require './test/test_helper'

class KeyCrackerTest < Minitest::Test
  attr_reader :key_cracker, :file_fragment, :original_key_used
  def setup
    file_fragment = "sAoC2sA"
    file_string_length = 78
    offsets = {:A_offset => 1,
               :B_offset => 1,
               :C_offset => 2,
               :D_offset => 2,
               :E_offset => 5}
    @key_cracker = KeyCracker.new(file_fragment, file_string_length, offsets)
    @original_key_used = 24674
  end
  
  def test_it_prepares_last_five_of_fragment
    expected = ["o", "C", "2", "s", "A"] 
    actual = key_cracker.prepared_fragment
    
    assert_equal expected, actual
  end
  
  def test_it_knows_how_many_values_come_before_fragment
    expected = 73
    actual = key_cracker.values_before_fragment
    
    assert_equal expected, actual
  end
  
  def test_it_sorts_last_five_matched_fragments_by_offset_group
    expected = [["2", "d"], ["s", "."], ["A", "."], ["o", "e"], ["C", "n"]]
    actual = key_cracker.sort_by_offset_position
    
    assert_equal expected, actual
  end
  
  def test_it_finds_difference
    known_value = "e"
    encrypted_value = "y"
    
    expected = 20
    actual = key_cracker.value_diff(encrypted_value, known_value)
    
    assert_equal expected, actual
  end
  
  def test_it_finds_difference_when_encrypted_comes_before
    known_value = "."
    encrypted_value = "S"
    
    expected = 21
    actual = key_cracker.value_diff(encrypted_value, known_value)
    
    assert_equal expected, actual
  end
  
  def test_it_knows_which_offset
    expected = 5
    actual = key_cracker.which_offset(4)
    
    assert_equal expected, actual
  end
  
  def test_it_calculates_rotation
    difference = 21
    offset = 7
    
    expected = "14"
    actual = key_cracker.calculate_rotation(difference, offset)
    
    assert_equal expected, actual
  end
  
  def test_it_builds_rotations
    expected = ["24", "46", "01", "08", "24"]
    actual = key_cracker.build_rotations
    
    assert_equal expected, actual
  end

  def test_it_builds_key
    expected = original_key_used
    actual = key_cracker.build_key
    
    assert_equal expected, actual 
  end
  
end
