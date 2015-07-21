class KeyGenerator
  attr_reader :key
  
  def initialize(key = random_key)
    @key = key
  end
  
  def random_key
    rand(10000..99999)
  end 
  
end
