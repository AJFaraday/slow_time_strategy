class City < Token

  attr_accessor :health

  def initialize(x, y, owner, grid=nil)
    super(x, y, owner, grid)
    @health = 10
  end

  def calculate_movement
    if (@grid.game.turn % @grid.game.config.spawn_interval) == 0
      target, target_x, target_y = next_step
      if target
        if target.owner == owner
          -> {target.heal(1)}
        else
          # This shouldn't actually happen
          -> {target.damage(1)}
        end
      else
        -> {@grid.add_token(target_x, target_y, Walker, owner)}
      end
    end
  end

end
