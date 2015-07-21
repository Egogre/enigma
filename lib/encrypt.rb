class Encrypt
  
  def initialize(read_file, write_file)
    @read_file = read_file
    @write_file = write_file
  end
  
  def encrypt_file
    
  end
  
end

if __FILE__ == $0

  input_file = ARGV[0]
  read_file = File.open(input_file)
  output_file = ARGV[1]
  write_file = File.new(output_file, 'w')
  encryptor = Encrypt.new(read_file, write_file)
  encryptor.encrypt_file
end
