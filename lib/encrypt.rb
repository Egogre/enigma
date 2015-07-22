require './lib/key_generator'
require './lib/offset_calculator'
require './lib/rotation_calculator'
require './lib/string_encryptor'

class Encrypt
  attr_reader :read_file, :write_file, :key
  
  def initialize(read_file, write_file, key = encryption_key)
    @read_file = read_file
    @write_file = write_file
    @key = key
  end
  
  def encrypt_file
    write_file.write(encrypted_string)
    write_file.flush
  end
  
  def encryption_key
    KeyGenerator.new.key
  end
  
  private
  
  def file_string
    read_file.read
  end
  
  def file_date
    write_file.birthtime
  end
  
  def offsets
    OffsetCalculator.new(file_date).offsets
  end
  
  def rotations
    RotationCalculator.new(key).rotations
  end
  
  def encrypted_string
    encryptor = StringEncryptor.new(file_string, rotations, offsets)
    encryptor.encrypt_string
  end
  
end

if __FILE__ == $0

  input_file = ARGV[0]
  read_file = File.open(input_file)
  output_file = ARGV[1]
  write_file = File.new(output_file, 'w')
  key = ARGV[2].to_i
  encryptor = Encrypt.new(read_file, write_file)
  encryptor.encrypt_file
  p "Created #{ARGV[1]} with the key '#{encryptor.key}' and date '#{write_file.birthtime}'"
  write_file.close
end
