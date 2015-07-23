require './test/test_helper'

class KeyJudgerTest < Minitest::Test
  attr_reader :the_key_judicator
  
  def setup
    build_rotations = ["24", "46", "01", "08", "24"]
    @the_key_judicator = KeyJudger.new(build_rotations)
  end
  
  def test_it_tests_for_rotating_all_the_way_through
    expected = [["24", "90"], ["46"], ["01", "67"], ["08", "74"], ["24", "90"]]
    actual = the_key_judicator.rotation_options
    
    assert_equal expected, actual
  end
  
  def test_it_compares_options_for_fit
    refute the_key_judicator.judge_key_fragments("24", "35")
    assert the_key_judicator.judge_key_fragments("24", "45")
  end
  
  def test_it_selects_based_on_judgement
    expected = [["24"], ["46"], ["67"], ["74"]]
    actual = the_key_judicator.working_key_fragments
    
    assert_equal expected, actual
  end
  
  def test_it_verifies_with_e_possibles
    expected = ["24", "46", "67", "74", "24"]
    actual = the_key_judicator.confirmed_fragments
    
    assert_equal expected, actual
  end
  
end