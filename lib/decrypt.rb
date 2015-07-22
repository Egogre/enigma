require './lib/offset_calculator'
require './lib/rotation_calculator'
require './lib/string_decryptor'

class Decrypt
  attr_reader :read_file, :write_file, :key
  
  def initialize(read_file, write_file, key)
    @read_file = read_file
    @write_file = write_file
    @key = key
  end
  
  def decrypt_file
    write_file.write(decrypted_string)
    write_file.flush
  end
  
  private
  
  def file_string
    read_file.read
  end
  
  def file_date
    read_file.birthtime
  end
  
  def offsets
    OffsetCalculator.new(file_date).offsets
  end
  
  def rotations
    RotationCalculator.new(key).rotations
  end
  
  def decrypted_string
    decryptor = StringDecryptor.new(file_string, rotations, offsets)
    decryptor.decrypt_string
  end
  
  
end

if __FILE__ == $0

  input_file = ARGV[0]
  read_file = File.open(input_file)
  output_file = ARGV[1]
  write_file = File.new(output_file, 'w')
  key = ARGV[2]
  decryptor = Decrypt.new(read_file, write_file, key)
  decryptor.decrypt_file
  p "Created #{ARGV[1]} with the key '#{decryptor.key}' and date '#{read_file.birthtime}'"
  write_file.close
end
