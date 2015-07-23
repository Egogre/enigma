class KeyJudger
  attr_reader :build_rotations
  
  def initialize(build_rotations)
    @build_rotations = build_rotations
  end
  
  def rotation_options
    build_rotations.map do |rotation|
      include_add_sixty_six_to(rotation)
    end
  end
  
  def judge_key_fragments(fragment_a, fragment_b)
    fragment_a[1] == fragment_b[0] if fragment_b
  end
  
  def judge_key_fragments_backwards(fragment_a, fragment_b)
    fragment_a[0] == fragment_b[1] if fragment_b
  end
  
  def confirmed_fragments
    all_judged_values = narrow_down_e
    verify(all_judged_values)
    all_judged_values.flatten
  end
  
  def working_key_fragments
    working_frags = narrow_down_possible_key_frags_forwards
    working_frags << narrow_down_possible_key_frags_backwards
  end
  
  private
  
  def include_add_sixty_six_to(rotation)
    if (rotation.to_i + 66) < 100
      [rotation] << (rotation.to_i + 66).to_s
    else
      [rotation]
    end
  end
  
  def possible_key_frags
    rotation_options[0..3]
  end
  
  def e_key_values
    rotation_options[4]
  end
  
  def judge_possibles_against_eachother(possible_rotations, index)
    possible_rotations.select do |rotation_in_quetion|
      judge_key_fragments(rotation_in_quetion, possible_key_frags[index +1][0]) || judge_key_fragments(rotation_in_quetion, possible_key_frags[index +1][1])
    end
  end
  
  def judge_possibles_against_eachother_backwards(possible_rotations, index)
    possible_rotations.select do |rotation_in_quetion|
      judge_key_fragments_backwards(rotation_in_quetion, possible_key_frags[index][0]) || judge_key_fragments_backwards(rotation_in_quetion, possible_key_frags[index][1])
    end
  end
  
  def narrow_down_possible_key_frags_forwards
    working_frags = []
    possible_key_frags[0..2].each_with_index do |possible_rotations, index|
      working_frags << judge_possibles_against_eachother(possible_rotations, index)
    end
    working_frags
  end
  
  def narrow_down_possible_key_frags_backwards
    judge_possibles_against_eachother_backwards(possible_key_frags[3], 2)
  end
  
  def narrow_down_e
    working_e_values = e_key_values.select do |value|
      value[0] == working_key_fragments[0][0][0] && value[1] == working_key_fragments[3][0][1]
    end
    working_key_fragments << working_e_values
  end
  
  def verify(all_judged_values)
    all_judged_values[0].select { |value| value[0] == all_judged_values[4][0]}
    all_judged_values[3].select { |value| value[1] == all_judged_values[4][1]}
  end
  
end