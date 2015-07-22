require './test/test_helper'

class EncryptTest < Minitest::Test
  
  def test_user_happy_path
    read_file = File.open('./test/sample_message.txt')
    write_file = File.new('./test/encrypted_message.txt', 'w')
    key = 12148
    encryptor = Encrypt.new(read_file, write_file, key)
    encryptor.encrypt_file
    check_file = File.open('./test/encrypted_message.txt')
    check_read = check_file.read
    read_file.rewind
    test_read = read_file.read
    read_file.close
    check_file.close
    
    refute test_read == check_read
    
    expected = test_read.length
    actual = check_read.length
    
    assert_equal expected, actual
  end

end
