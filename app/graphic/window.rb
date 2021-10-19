require_relative('../../environment')
require 'gosu'

module Graphic
  class Window < Gosu::Window

    include Sprites

    TILE_SIZE = 35
    BACKGROUND_COLOUR = 0xff_007700

    LAYERS = {
      background: 0,
      units: 1,
      houses: 2,
      ui: 3
    }

    attr_reader :turn_time, :phase, :reporter

    def initialize(game)
      @game = game
      super(
        @game.config.x_size * TILE_SIZE,
        @game.config.y_size * TILE_SIZE,
        false
      )
      @turn_time = @game.config.turn_time
      @last_update = Time.now - 10000
      self.caption = "Grid Game: #{@game.name}"
      @phase = 0
      @font = Gosu::Font.new(20)
      @reporter = Graphic::Reporter.new(game, self)
      game.add_reporter(@reporter)
    end

    def update
      take_turn
      @reporter.tokens.each do |graphic_token|
        graphic_token.take_step if graphic_token.walker?
      end
    end

    def take_turn
      if time_to_update?
        @last_update = Time.now
        @phase = (@phase + 1) % 2
        if @phase == 0
          puts "#{@game.turn} damage"
          @game.turn_runner.calculate_damage
          @game.turn_runner.enact_changes
        else
          puts "#{@game.turn} movement"
          @game.turn_runner.calculate_movement
          @game.turn_runner.enact_changes
          @game.turn += 1
        end
      end
    end

    def time_to_update?
      Time.now >= @last_update + @turn_time
    end

    def draw
      draw_background
      if @phase == 1
        @walker_image = walker_sprite[Gosu.milliseconds / 100 % 6]
      else
        @walker_image = walker_sprite[0]
      end
      @reporter.tokens.each do |graphic_token|
        if graphic_token.walker?
          draw_walker(graphic_token)
        else
          # city
          house_sprite.draw_rot(graphic_token.x, graphic_token.y, LAYERS[:houses], 0, 0.5, 0.5)
        end
      end
    end

    def draw_walker(token)
      @walker_image.draw_rot(token.x, token.y, LAYERS[:units], token.rotation, 0.5, 0.5)
      @font.draw_text(token.health, token.x, token.y, LAYERS[:ui], 1,1,token.owner.colour)
    end

    def draw_background
      draw_rect(0, 0, self.width, self.height, BACKGROUND_COLOUR, LAYERS[:background])
    end

  end
end
