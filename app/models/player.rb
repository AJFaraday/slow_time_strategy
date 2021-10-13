class Player

  attr_accessor :tokens, :colour
  attr_accessor :direction

  def initialize(colour = '#000000')
    @colour = colour
    @tokens = []
  end

end
