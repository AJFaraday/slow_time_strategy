class Token

  include Directions

  # initial health is the health of this token at the start of any given turn
  attr_accessor :x, :y, :owner, :health, :initial_health, :fought_in_turn

  def initialize(x, y, owner, grid = nil)
    @x = x
    @y = y
    @owner = owner
    @grid = grid
    @game = grid.game if grid.respond_to?(:game)
    # Always overridden
    @health = 1000
    @fought_in_turn = []
  end

  def start_turn
    @fought_in_turn.clear
  end

  def calculate_damage
    initial_health = @health
    adjacent_enemies.map do |enemy|
      -> { self.fight(enemy, initial_health, false) }
    end
  end

  def calculate_movement
    raise "calculate_movement called on Token, should be City or Walker"
  end

  # This must be symmetrical!
  def fight(other, initial_health, walking = true)
    unless fought_in_turn.include?(other)
      self.fought_in_turn << other
      other.fought_in_turn << self
      self.damage(other.health)
      other.damage(initial_health)
      if self.health > 0 && walking
        @grid.move_token(self.x, self.y, other.x, other.y)
      end
    end
  end

  def damage(amount)
    @health -= amount
    if @health <= 0
      @owner.tokens.delete(self)
      @grid.remove_token(x, y)
      @game.report(:remove_token, {game_token: self})
      @health = 0
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
    return target_x, target_y
  end

end
