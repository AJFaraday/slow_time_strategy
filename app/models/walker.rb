class Walker < Token

  attr_accessor :health

  def initialize(x, y, owner, grid = nil)
    super(x, y, owner, grid)
    @health = 1
  end

  def calculate_movement
    target, target_x, target_y = next_step
    initial_health = @health
    if target
      if target.owner == owner
        if target.is_a?(Walker)
          -> do
            target.heal(self.health)
            @grid.remove_token(@x, @y)
          end
        end
      else
        -> do
          self.fight(target, initial_health, true)
        end
      end
    else
      if @grid.in_range?(target_x, target_y)
        -> do
          if @grid.token_at(target_x, target_y)
            self.fight(@grid.token_at(target_x, target_y), initial_health, true)
          else
            @grid.move_token(@x, @y, target_x, target_y)
          end
        end
      else
      end
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
