require './lib/key_judger'

class KeyCracker
  
  CHARACTERS = ["A", "B", "C", "D", "E", "F", "G", "H",
                "I", "J", "K", "L", "M", "N", "O", "P",
                "Q", "R", "S", "T", "U", "V", "W", "X",
                "Y", "Z", "a", "b", "c", "d", "e", "f",
                "g", "h", "i", "j", "k", "l", "m", "n",
                "o", "p", "q", "r", "s", "t", "u", "v",
                "w", "x", "y", "z", "0", "1", "2", "3",
                "4", "5", "6", "7", "8", "9", " ", ".",
                ",", "\n"]
                
  attr_reader :file_fragment, :file_string_length, :offsets              
  
  def initialize(file_fragment, file_string_length, offsets)
    @file_fragment = file_fragment
    @file_string_length = file_string_length
    @offsets = offsets
  end
  
  def prepared_fragment
    file_fragment.split('')[-5..-1]
  end
  
  def values_before_fragment
    file_string_length - prepared_fragment.length
  end
  
  def sort_by_offset_position
    sorted_character_index.map {|pair_index| pair_index[0]}
  end
  
  def value_diff(encrypted, known)
    if known_index(known) > encrypted_index(encrypted)
      (66 - known_index(known)) + encrypted_index(encrypted)
    else
      encrypted_index(encrypted) - known_index(known)
    end
  end
  
  def which_offset(index)
    offset = a_offset if (index % 5) == 0
    offset = b_offset if (index % 5) == 1
    offset = c_offset if (index % 5) == 2
    offset = d_offset if (index % 5) == 3
    offset = e_offset if (index % 5) == 4
    offset
  end
  
  def calculate_rotation(difference, offset)
    (difference - offset).to_s.rjust(2, "0")
  end
  
  def build_rotations
    rotations = []
    differences.each_with_index do |diff, index|
      rotations << calculate_rotation(diff, which_offset(index))
    end
    rotations
  end
  
  def build_key
    key_judicator = KeyJudger.new(build_rotations)
    
    key_piece_a = key_judicator.confirmed_fragments[0]
    key_piece_b = key_judicator.confirmed_fragments[2]
    key_piece_c = key_judicator.confirmed_fragments[3][1]
    
    (key_piece_a + key_piece_b + key_piece_c).to_i
  end
  
  private
  
  def known_fragment
    "end.."
  end
  
  def encrypted_matched_with_known
    paired = []
    prepared_fragment.each_with_index do |character, index|
      paired << [character, known_fragment[index]]
    end
    paired
  end
  
  def known_index(known)
    CHARACTERS.index(known) 
  end
  
  def encrypted_index(encrypted)
    CHARACTERS.index(encrypted)
  end
  
  def character_index
    characters_with_index = []
    encrypted_matched_with_known.each_with_index do |pair, index|
      characters_with_index << [pair, (values_before_fragment + index) % 5]
    end
    characters_with_index    
  end
  
  def sorted_character_index
    character_index.sort_by {|pair_index| pair_index[1]}
  end
  
  def differences
    sort_by_offset_position.map {|pair| value_diff(pair[0], pair[1])}
  end

  def a_offset
    offsets[:A_offset]
  end

  def b_offset
    offsets[:B_offset]
  end

  def c_offset
    offsets[:C_offset]
  end
  
  def d_offset
    offsets[:D_offset]
  end
  
  def e_offset
    offsets[:E_offset]
  end
  
end
