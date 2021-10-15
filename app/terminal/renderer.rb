module Terminal

  class Renderer

    attr_reader :game, :x_size, :y_size

    TOKEN_WIDTH = 4

    def initialize(game)
      @game = game
      @x_size = @game.config.x_size
      @y_size = @game.config.y_size
      @frame_width = (@x_size * TOKEN_WIDTH) + 3
    end

    def draw
      puts `clear`
      frame = build_frame
      @game.grid.tokens.each do |token|
        token_index = get_index_for(token)
        # todo colorize and then work out how to find location after hidden chars
        frame[token_index..token_index+(TOKEN_WIDTH-1)] = "#{@game.players.index(token.owner)}#{token.class.to_s[0]}#{token.health.to_s.rjust(2, '0')}"
      end
      puts frame
    end

    private

    def get_index_for(token)
      y = @frame_width * (token.y + 1)
      x = (token.x * TOKEN_WIDTH) + 1
      x + y
    end

    def build_frame
      return @template_frame.dup if @template_frame
      @template_frame = "+#{'-' * x_size * TOKEN_WIDTH}+\n"
      @template_frame << "|#{' ' * x_size * TOKEN_WIDTH}|\n" * y_size
      @template_frame << "+#{'-' * x_size * TOKEN_WIDTH}+\n"
      build_frame
    end

  end

end