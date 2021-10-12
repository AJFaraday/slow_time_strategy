class Walker < Token

  attr_accessor :health

  def initialize(x, y, owner, grid=nil)
    @health = 1
    super(x, y, owner, grid)
  end

  def calculate_damage
    raise "calculate_damage not yet implemented on Walker"
  end

  def calculate_movement
    raise "calculate_movement not yet implemented on Walker"
  end

end
