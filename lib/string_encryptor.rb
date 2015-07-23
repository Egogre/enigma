class StringEncryptor
  CHARACTERS = ["A", "B", "C", "D", "E", "F", "G", "H",
                "I", "J", "K", "L", "M", "N", "O", "P",
                "Q", "R", "S", "T", "U", "V", "W", "X",
                "Y", "Z", "a", "b", "c", "d", "e", "f",
                "g", "h", "i", "j", "k", "l", "m", "n",
                "o", "p", "q", "r", "s", "t", "u", "v",
                "w", "x", "y", "z", "0", "1", "2", "3",
                "4", "5", "6", "7", "8", "9", " ", ".",
                ",", "\n"]
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
  
  def encrypt_string
    encrypted_characters = []
    prepared_string.each_with_index do |character, index|
      encrypted_characters << character_shift(character, which_rotation(index), which_offset(index))
    end
    encrypted_characters.join('')      
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
