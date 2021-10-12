class City < Token

  attr_accessor :health

  def initialize(x, y, owner, grid=nil)
    @health = 10
    super(x, y, owner, grid)
  end

  def calculate_damage
    raise "calculate_damage not yet implemented on City"
  end

  def calculate_movement
    raise "calculate_movement not yet implemented on City"
  end

end
