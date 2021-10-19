module Graphic
  class Reporter

    def initialize(game, window)
      @game = game
      @window = window
      build_tokens
    end

    # {game_token:}
    def add_token(opts)
      @tokens[opts[:game_token].object_id] = Graphic::Token.new(opts[:game_token], @window, opts[:from])
    end

    # {game_token:}
    def remove_token(opts)
      if opts[:to]
        graphic_token = @tokens[opts[:game_token].object_id]
        graphic_token.doomed = true
        graphic_token.set_coord(opts[:to].x, opts[:to].y)
      else
        @tokens.delete(opts[:game_token].object_id)
      end
    end

    # {game_token: , x: 1, y: 1}
    def move_token(opts)
      token = @tokens[opts[:game_token].object_id]
      token.set_coord(opts[:x], opts[:y], opts[:from])
    end

    def tokens
      @tokens.values
    end

    private

    def build_tokens
      @tokens = {}
      @game.grid.tokens.each do |token|
        add_token({ game_token: token })
      end
    end

  end
end
