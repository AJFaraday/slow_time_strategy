class Walker < Token

  attr_accessor :health

  def initialize(x, y, owner, grid = nil)
    super(x, y, owner, grid)
    @health = 1
  end

  def calculate_movement
    target, target_x, target_y = next_step
    if target
      if target.owner == owner
        -> do
          target.heal(self.health)
          @grid.remove_token(@x, @y)
        end
      else
        # This shouldn't actually happen
        -> do
          target.damage(self.health)
          @grid.remove_token(@x, @y)
        end
      end
    else
      -> { @grid.move_token(@x, @y, target_x, target_y) }
    end
  end

  def heal(amount)
    @health += amount
    if @health >= 10
      @grid.remove_token(x, y)
      @owner.tokens.delete(self)
      @grid.add_token(x, y, City, owner)
    end
  end

end
