class Player

  attr_accessor :tokens, :colour

  def initialize(colour='#000000')
    @colour = colour
    @tokens = []
  end

  def method_missing(meth, *args, &block)
    if %i[calculate_movement enact_movement calculate_damage enact_damage].include?(meth)
      tokens.each{|t|t.send(meth)}
    else
      super
    end
  end

end