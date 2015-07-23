require './test/test_helper'

class CrackTest < Minitest::Test
  
  def test_user_happy_path
    read_file = File.open('./test/crack_me_test.txt')
    write_file = File.new('./test/cracked_message.txt', 'w')
    cracker = Crack.new(read_file, write_file)
    cracker.crack_file
    check_file = File.open('./test/cracked_message.txt')
    check_read = check_file.read
    read_file.rewind
    test_read = read_file.read
    original_file = File.open('./test/message_to_encode_for_cracking.txt')
    original_read = original_file.read
    read_file.close
    check_file.close
    original_file.close
    
    refute test_read == check_read
    
    expected = test_read.length
    actual = check_read.length
    
    assert_equal expected, actual
    assert_equal original_read, check_read
  end
  
end
