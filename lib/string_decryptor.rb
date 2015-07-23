class StringDecryptor
  CHARACTERS = ["\n", ",", ".", " ", "9", "8", "7", "6",
                "5", "4", "3", "2", "1", "0", "z", "y",
                "x", "w", "v", "u", "t", "s", "r", "q",
                "p", "o", "n", "m", "l", "k", "j", "i",
                "h", "g", "f", "e", "d", "c", "b", "a",
                "Z", "Y", "X", "W", "V", "U", "T", "S",
                "R", "Q", "P", "O", "N", "M", "L", "K",
                "J", "I", "H", "G", "F", "E", "D", "C",
                "B", "A"]
  attr_reader :string, :rotations, :offsets
  
  def initialize(string, rotations, offsets)
    @string = string
    @rotations = rotations
    @offsets = offsets
  end
  
  def prepared_string
    string.split('')
  end
  
  def character_shift(character, rotation, offset)
    pos = new_position(character, rotation, offset) 
    CHARACTERS[pos]
  end
  
  def decrypt_string
    decrypted_characters = []
    prepared_string.each_with_index do |character, index|
      decrypted_characters << character_shift(character, which_rotation(index), which_offset(index))
    end
    decrypted_characters.join('')      
  end  
  
  private
  
  def current_position(character)
    CHARACTERS.index(character)
  end
  
  def new_position(character, rotation, offset)
    c = current_position(character)
    r = rotation
    o = offset
    (c + r + o) % 66
  end
  
  def a_rotation
    rotations[:A_rotation]
  end
  
  def a_offset
    offsets[:A_offset]
  end
  
  def b_rotation
    rotations[:B_rotation]
  end
  
  def b_offset
    offsets[:B_offset]
  end
  
  def c_rotation
    rotations[:C_rotation]
  end
  
  def c_offset
    offsets[:C_offset]
  end
  
  def d_rotation
    rotations[:D_rotation]
  end
  
  def d_offset
    offsets[:D_offset]
  end
  
  def e_rotation
    rotations[:E_rotation]
  end
  
  def e_offset
    offsets[:E_offset]
  end
  
  def which_rotation(index)
    rotation = a_rotation if (index % 5) == 0
    rotation = b_rotation if (index % 5) == 1
    rotation = c_rotation if (index % 5) == 2
    rotation = d_rotation if (index % 5) == 3
    rotation = e_rotation if (index % 5) == 4
    rotation
  end
  
  def which_offset(index)
    offset = a_offset if (index % 5) == 0
    offset = b_offset if (index % 5) == 1
    offset = c_offset if (index % 5) == 2
    offset = d_offset if (index % 5) == 3
    offset = e_offset if (index % 5) == 4
    offset
  end
  
end
