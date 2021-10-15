require_relative('../../environment')

describe 'scenarios' do

=begin
     VVVV - error
+------------------------------------------------------------+
|1C10                                                        |
|1C10                                                        |
|1W08****0C10                                    0C100C100C10| <<<< - Error
|1W01    0W01                                    0W010W010W01|
|                                                            |
|                                                            |
|1W011W011W01                                    1W01    0W01|
|1C101C101C10                                    1C10    0W08|
|                                                        0C10|
|                                                        0C10|
+------------------------------------------------------------+
=end
  it 'A: Attacking and spawning on same spot (turn 108)' do
    game = Game.new('test')
    game.add_player('red')
    game.add_player('green')

    100.times { game.take_turn }
    game.players[0].direction = 'S'
    game.players[1].direction = 'N'

    90.times { game.take_turn }
    game.players[0].direction = 'W'
    game.players[1].direction = 'E'

    expect { game.take_turn }.not_to raise_error
  end

=begin
  +------------------------------------------------------------+
  |                                                            |
  |                                                            |
  |                                                            |
  |                                                            |
  |                                                            |
  |                                                            |
  |                                                            |
  |                                                1C10    0W01|
  |                                                            |
  |                                                            |
  +------------------------------------------------------------+
=end

  it "A: Attacking and spawning on same spot (subset)" do
    game = Game.new('test')
    game.add_player('red')
    game.add_player('green')
    game.players[0].direction = 'W'
    game.players[1].direction = 'E'
    game.grid.remove_token(2, 2)
    game.grid.add_token(14, 7, Walker, game.players[0])

    game.send(:turn_runner).calculate_movement
    expect { game.send(:turn_runner).enact_changes }.not_to raise_error
  end

=begin
  +------------------------------------------------------------+
  |                                                            |
  |                                                            |
  |                                                            |
  |                                                            |
  |                                                            |
  |                    0W06    1W02                            |
  |                            1W02                            |
  |                                                            |
  |                                                            |
  |                                                            |
  +------------------------------------------------------------+
=end
  # The walker with 6 should fight each 2 in turn and end up with 2 (6 - 2 - 2)

  it "B: only carries out fights once" do
    game = Game.new('test')
    game.add_player('red')
    game.add_player('green')
    game.players[0].direction = 'E'
    game.players[1].direction = 'W'
    game.grid.remove_token(2, 2)
    game.grid.remove_token(12, 7)

    walker = game.grid.add_token(6, 5, Walker, game.players[0])
    enemy1 = game.grid.add_token(7, 5, Walker, game.players[1])
    enemy2 = game.grid.add_token(7, 6, Walker, game.players[1])
    walker.health = 6
    enemy1.health = 2
    enemy2.health = 2

    game.draw_to_console
    game.take_turn
    game.draw_to_console

    expect(game.grid.token_at(6,5)).to be_nil
    expect(game.grid.token_at(7,5)).to be_nil
    expect(game.grid.token_at(7,6)).to be_nil
    expect(game.grid.tokens).to include(walker)
    expect(walker.health).to eq(2)
  end

end
