class Player

  attr_accessor :tokens, :colour

  def initialize(colour='#000000')
    @colour = colour
    @tokens = []
  end

  def method_missing(meth, *args, &block)
    if Turn::PHASES.include?(meth)
      tokens.each{|t|t.send(meth)}
    else
      super
    end
  end

end