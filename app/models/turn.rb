class Turn

  PHASES = %i{calculate_damage enact_changes calculate_movement enact_changes}

  attr_reader :game, :grid, :players
  attr_accessor :changes

  def initialize(game)
    @game = game
    @grid = game.grid
    @players = game.players
    @changes = []
  end

  def perform
    PHASES.each { |phase| send(phase)}
  end

  def calculate_damage
    @changes = game.tokens.map(&:calculate_damage)
  end

  def calculate_movement
    @changes = game.tokens.map(&:calculate_movement)
  end

  def enact_changes
    @changes.each(&:call)
  end

end
