require './test/test_helper'

class DecryptTest < Minitest::Test
  
  def test_user_happy_path
    read_file = File.open('./test/sample_files/encrypted_message.txt')
    write_file = File.new('./test/sample_files/decrypted_message.txt', 'w')
    key = 12148
    decryptor = Decrypt.new(read_file, write_file, key)
    
    decryptor.decrypt_file
    
    check_file = File.open('./test/sample_files/decrypted_message.txt')
    check_read = check_file.read
    read_file.rewind
    test_read = read_file.read
    original_file = File.open('./test/sample_files/sample_message.txt')
    original_read = original_file.read
    original_file.close
    read_file.close
    check_file.close
    
    refute test_read == check_read
    
    expected = test_read.length
    actual = check_read.length
    
    assert_equal expected, actual
    assert_equal original_read, check_read
  end
  
  
end
