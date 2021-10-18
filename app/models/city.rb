class City < Token

  attr_accessor :health

  def initialize(x, y, owner, grid = nil)
    super(x, y, owner, grid)
    @health = 10
  end

  def calculate_movement
    if (@grid.game.turn % @grid.game.config.spawn_interval) == 0
      target_x, target_y = next_step
      if @grid.in_range?(target_x, target_y)
        -> do
          target = @grid.token_at(target_x, target_y)
          if target
            if target.owner == owner
              target.heal(1)
            else
              target.damage(1)
            end
          else
            @grid.add_token(target_x, target_y, Walker, owner)
          end
        end
      end
    end
  end

end
