class Token

  attr_accessor :x, :y, :owner

  def initialize(x, y, owner, grid=nil)
    @x = x
    @y = y
    @owner = owner
    @grid = grid
  end

  def calculate_movement
    raise "calculate_movement called on Token, should be City or Walker"
  end

  def enact_movement
    raise "enact_movement called on Token, should be City or Walker"
  end

  def calculate_damage
    raise "calculate_damage called on Token, should be City or Walker"
  end

  def enact_damage
    raise "enact_damage called on Token, should be City or Walker"
  end

end
