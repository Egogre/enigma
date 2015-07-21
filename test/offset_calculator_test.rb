require './test_helper'

class OffsetCalculatorTest < Minitest::Test
  attr_reader :ocalc
  
  def setup
    file = File.open('./sample_message.txt')
    message_date = file.mtime
    @ocalc = OffsetCalculator.new(message_date)
  end
  
  def test_it_gets_date_in_ddmmyy_format
    expected = 200715
    actual = ocalc.date_ddmmyy
    
    assert_equal expected, actual
  end
  
  def test_it_calculates_offset
    expected = {:A_offset => 1,
                :B_offset => 2,
                :C_offset => 2,
                :D_offset => 5}
    actual = ocalc.offset
    
    assert_equal expected, actual
  end
  
end
