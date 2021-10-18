require_relative '../environment'
require 'benchmark'

game = Game.new('huge')
game.add_player('red')
game.add_player('green')
grid = Terminal::Renderer.new(game)

def draw_state(game, grid)
  #grid.draw
  puts game.turn
  puts game.grid.tokens.count
end

turn_time = 0.05
error = false
until error do
  begin
    if game.turn == 100
      game.players[0].direction = 'S'
      game.players[1].direction = 'N'
      turn_time = 0.05
    end
    if game.turn >= 200
      dirs = %W{N S W E}
      game.players[0].direction = dirs[rand(4)]
      game.players[1].direction = dirs[rand(4)]
      turn_time = 0.05
    end

    puts `clear`
    bm = Benchmark.measure do
      game.take_turn
    end
    draw_state(game, grid)
    puts bm.total
    sleep turn_time
  rescue => er
    game.draw_to_console
    puts er.message
    puts er.backtrace
    error = true
  end
end
