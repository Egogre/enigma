require './test_helper'

class EncryptTest < Minitest::Test
  
  def test_user_happy_path
    input_file = File.open('./sample_message.txt')
    string = input_file.read
    encryptor = StringEncryptor.new(string)
    encrypted_string = encryptor.encrypt
    output_file = File.new('./encrypted_message.txt', 'w')
    output_file.write(encrypted_string)
    output_file.flush
    output_file.rewind
    check_read = output_file.read
    
    refute string == check_read
    
    expected = string.length
    actual = check_read.length
    
    assert_equal expected, actual
  end

end
