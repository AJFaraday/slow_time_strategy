require_relative '../environment'

game = Game.new('duel')
game.add_player('red')
game.add_player('green')
grid = Terminal::Renderer.new(game)

def draw_state(game, grid,note)
  grid.draw
  puts game.turn
  puts note
end

turn_time = 0
loop do
  if game.turn == 100
    game.players[0].direction = 'S'
    game.players[1].direction = 'N'
    turn_time = 0
  end
  if game.turn == 190
    game.players[0].direction = 'W'
    game.players[1].direction = 'E'
    turn_time = 1
  end
  game.send(:turn_runner).calculate_damage
  game.send(:turn_runner).enact_changes
  draw_state(game, grid,'damage')
  sleep(turn_time)
  game.send(:turn_runner).calculate_movement
  game.send(:turn_runner).enact_changes
  draw_state(game, grid, 'movement')
  game.instance_variable_set(:@turn, game.turn + 1)
  sleep turn_time
  puts `clear`
end
