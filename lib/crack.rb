require './lib/offset_calculator'
require './lib/rotation_calculator'
require './lib/string_decryptor'
require './lib/key_cracker'

class Crack
  attr_reader :read_file, :write_file, :date
  
  def initialize(read_file, write_file, date = file_date)
    @read_file = read_file
    @write_file = write_file
    @date = date
  end
  
  def crack_file
    write_file.write(cracked_string)
    write_file.flush
  end
  
  def cracked_key
    key_cracker = KeyCracker.new(file_fragment, file_string.length, offsets)
    key_cracker.build_key
  end
  
  private
  
  def file_string
    read_file.rewind
    read_file.read
  end
  
  def file_fragment
    file_string[-5..-1]
  end
  
  def file_date
    read_file.birthtime
  end
  
  def offsets
    OffsetCalculator.new(date).offsets
  end
  
  def cracked_rotations
    RotationCalculator.new(cracked_key).rotations
  end
  
  def cracked_string
    decryptor = StringDecryptor.new(file_string, cracked_rotations, offsets)
    decryptor.decrypt_string
  end
  
end

if __FILE__ == $0

  input_file = ARGV[0]
  read_file = File.open(input_file)
  output_file = ARGV[1]
  write_file = File.new(output_file, 'w')
  date = ARGV[2]
  cracker = Crack.new(read_file, write_file)
  cracker.crack_file
  p "Created #{ARGV[1]} with the cracked key '#{cracker.cracked_key}' and date '#{cracker.date}'"
  write_file.close
end
