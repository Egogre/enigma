class StringEncryptor
  CHARACTERS = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h',
                'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p',
                'q', 'r', 's', 't', 'u', 'v', 'w', 'x',
                'y', 'z', ' ', '.', ',']
  attr_reader :string
  
  def initialize(string)
    @string = string
  end
  
  def prepare_string
    string.downcase.split('')
  end
  
end
