class Game

  attr_reader :grid, :players


  def initialize(config_name)
    file_path = File.join(__dir__, '../../config/games/', "#{config_name}.yml")
    @config = OpenStruct.new(YAML.load_file(file_path))
    @grid = Grid.new(@config.x_size, @config.y_size)
    @players = []
  end

  def add_player(colour='#000000')
    position = find_vacant_position
    if position
      player = Player.new(colour)
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
