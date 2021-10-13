class Token

  include Directions

  attr_accessor :x, :y, :owner, :health

  def initialize(x, y, owner, grid = nil)
    @x = x
    @y = y
    @owner = owner
    @grid = grid
    @game = grid.game if grid.respond_to?(:game)
    # Always overridden
    @health = 1000
  end

  def calculate_damage
    adjacent_enemies.map do |enemy|
      -> { enemy.damage(self.health) }
    end
  end

  def calculate_movement
    raise "calculate_movement called on Token, should be City or Walker"
  end

  def damage(amount)
    @health -= amount
    if @health <= 0
      @owner.tokens.delete(self)
      @grid.remove_token(x, y)
    end
  end

  def heal(amount)
    # No healing here, lol
  end

  def adjacent_enemies
    @grid
      .tokens_in_box(x - 1, y - 1, x + 1, y + 1)
      .select { |n| n.owner != self.owner }
  end

  private

  def next_step
    dir_x, dir_y = direction(owner.direction)
    target_x = @x + dir_x
    target_y = @y + dir_y
    return @grid.token_at(target_x, target_y), target_x, target_y
  end


end
