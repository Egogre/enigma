require './test_helper'

class RotationCalculatorTest < Minitest::Test
  attr_reader :rcalc
  
  def setup
    key = 12345
    @rcalc = RotationCalculator.new(key)
  end
  
  def test_it_calculates_rotation
    expected = {:A_rotation => 12,
                :B_rotation => 23,
                :C_rotation => 34,
                :D_rotation => 45}
    actual = rcalc.rotation
    
    assert_equal expected, actual
  end
  
end
