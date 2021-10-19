class Game

  attr_reader :grid, :players, :config, :name
  attr_accessor :turn

  def initialize(config_name)
    file_path = File.join(__dir__, '../../config/games/', "#{config_name}.yml")
    @name = config_name
    @config = OpenStruct.new(YAML.load_file(file_path))
    @grid = Grid.new(@config.x_size, @config.y_size, self)
    @players = []
    @turn = 0
    @reporters = []
  end

  def add_reporter(reporter)
    @reporters << reporter
  end

  def report(action, opts)
    @reporters.each do |reporter|
      if reporter.respond_to?(action)
        reporter.send(action, opts)
      end
    end
  end

  def add_player(colour='#000000')
    position = find_vacant_position
    if position
      player = Player.new(colour)
      player.direction = position['direction']
      @players << player
      city = grid.add_token(
        position['x'],
        position['y'],
        City,
        player
      )
      report(:add_token, {game_token: city})
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

  def timed_turn
    turn_start = Time.now
    take_turn
    turn_length = Time.now - turn_start
    sleep (@config.turn_time) - (turn_length/1000)
  end

  def run
    loop do
      timed_turn
    end
  end

  def turn_runner
    @turn_runner ||= TurnRunner.new(self)
  end

  private

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
