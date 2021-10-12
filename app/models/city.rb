class City < Token

  attr_accessor :health

  def initialize(x, y, owner, grid=nil)
    @health = 10
    super(x, y, owner, grid)
  end

end
