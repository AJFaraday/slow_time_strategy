class Walker < Token

  attr_accessor :health

  def initialize(x, y, owner, grid = nil)
    super(x, y, owner, grid)
    @health = 1
  end

  def calculate_movement
    target_x, target_y = next_step
    initial_health = @health
    if @grid.in_range?(target_x, target_y)
      -> do
        target = @grid.token_at(target_x, target_y)
        if target
          if target.owner == self.owner
            if target.is_a?(Walker)
              target.heal(initial_health)
              @grid.remove_token(x, y, true)
              @game.report(:remove_token, { game_token: self, to: target })
            end
          else
            self.fight(@grid.token_at(target_x, target_y), initial_health, true)
          end
        else
          @grid.move_token(@x, @y, target_x, target_y)
        end
      end
    end
  end

  def heal(amount)
    @health += amount
    if @health >= 10
      @grid.remove_token(x, y)
      @game.report(:remove_token, {game_token: self})
      @owner.tokens.delete(self)
      city = @grid.add_token(x, y, City, owner)
      @game.report(:add_token, { game_token: city })
    end
  end

end
