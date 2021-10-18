class TurnRunner

  PHASES = %i{start_turn calculate_damage enact_changes calculate_movement enact_changes}

  attr_reader :game, :changes

  def initialize(game)
    @game = game
    @grid = game.grid
    @changes = []
  end

  def perform
    PHASES.each { |phase| send(phase)}
  end

  def start_turn
    @grid.tokens.map(&:start_turn).flatten.compact
  end

  def calculate_damage
    @changes = @grid.tokens.map(&:calculate_damage).flatten.compact
  end

  def calculate_movement
    @changes = @grid.tokens.map(&:calculate_movement).flatten.compact
  end

  def enact_changes
    @changes.each(&:call)
  end

end
