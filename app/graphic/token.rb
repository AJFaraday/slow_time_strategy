module Graphic
  class Token

    include Geometry

    DIRS = {
      'N' => 0,
      'E' => 90,
      'S' => 180,
      'W' => 270,
    }

    attr_accessor :x, :y, :game_token, :doomed
    attr_accessor :start_x, :start_y

    def initialize(game_token, window, from = nil)
      @game_token = game_token
      @window = window
      @doomed = false
      set_coord(game_token.x, game_token.y, true, from)
    end

    def set_coord(x, y, initial = false, from = nil)
      if initial
        @x = convert_coord(x)
        @y = convert_coord(y)
        @step_start = Time.now
        @step_end = @step_start + @window.turn_time
        if from
          @start_x = convert_coord(from.x)
          @start_y = convert_coord(from.y)
        else
          @start_x ||= @x
          @start_y ||= @y
        end
        @target_x = @x
        @target_y = @y
      else
        @step_start = Time.now
        @step_end = @step_start + @window.turn_time
        @start_x = @x
        @start_y = @y
        @target_x = convert_coord(x)
        @target_y = convert_coord(y)
      end
    end

    def take_step
      proportion_of_step = range_to_proportion(@step_start, @step_end, Time.now)
      @x = proportion_to_step(@start_x, @target_x, proportion_of_step)
      @y = proportion_to_step(@start_y, @target_y, proportion_of_step)
      @window.reporter.remove_token({game_token: @game_token}) if @doomed && proportion_of_step == 1
    end

    def convert_coord(n)
      n * Graphic::Window::TILE_SIZE + (Graphic::Window::TILE_SIZE / 2)
    end

    def owner
      @game_token.owner
    end

    def health
      @game_token.health
    end

    def rotation
      DIRS[@game_token.owner.direction]
    end

    def city?
      @game_token.class == City
    end

    def walker?
      @game_token.class == Walker
    end

  end
end
