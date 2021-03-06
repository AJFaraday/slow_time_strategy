require_relative '../environment'
require 'benchmark'

game = Game.new('duel')
game.add_player('red')
game.add_player('green')
grid = Terminal::Renderer.new(game)

def draw_state(game, grid)
  grid.draw
  puts game.turn
end

error = false
until error do
  begin
    if game.turn % 10 == 0
      dirs = %W{N S W E}
      game.players[0].direction = dirs[rand(4)]
      game.players[1].direction = dirs[rand(4)]
    end
    game.timed_turn
    puts `clear`
    draw_state(game, grid)

  rescue => er
    game.draw_to_console
    puts er.message
    puts er.backtrace
  end
end
