require './test/test_helper'

class EncryptTest < Minitest::Test
  
  def test_user_happy_path
    skip
    read_file = File.open('./test/sample_message.txt')
    write_file = File.new('./test/encrypted_message.txt', 'w')
    encryptor = Encrypt.new(read_file, write_file)
    encrypted_file = encryptor.encrypt_file

    
    expected = string.length
    actual = check_read.length
    
    assert_equal expected, actual
  end

end
