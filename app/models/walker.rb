class Walker < Token

  attr_accessor :health

  def initialize(x, y, owner, grid=nil)
    @health = 1
    super(x, y, owner, grid)
  end

end
