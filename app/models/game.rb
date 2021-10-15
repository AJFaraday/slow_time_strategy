class Game

  attr_reader :grid, :players, :turn, :config

  def initialize(config_name)
    file_path = File.join(__dir__, '../../config/games/', "#{config_name}.yml")
    @config = OpenStruct.new(YAML.load_file(file_path))
    @grid = Grid.new(@config.x_size, @config.y_size, self)
    @players = []
    @turn = 0
  end

  def add_player(colour='#000000')
    position = find_vacant_position
    if position
      player = Player.new(colour)
      player.direction = position['direction']
      @players << player
      grid.add_token(
        position['x'],
        position['y'],
        City,
        player
      )
      player
    else
      raise "No positions left"
    end
  end

  def take_turn
    turn_runner.perform
    @turn += 1
  end

  # Mostly for debugging purposes
  def draw_to_console
    @terminal_renderer ||= Terminal::Renderer.new(self)
    @terminal_renderer.draw
  end

  private

  def turn_runner
    @turn_runner ||= TurnRunner.new(self)
  end

  def find_vacant_position
    positions = @config.starting_positions.dup
    position = nil
    until positions.empty?
      position = positions.shift
      if !grid.token_at(position['x'], position['y'])
        return position
      elsif positions.empty?
        return nil
      end
    end
  end

end
