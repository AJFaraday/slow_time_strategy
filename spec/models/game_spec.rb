require_relative('../../environment')

describe Game do

  let(:game) { Game.new('test') }

  it 'initializes with a config name' do
    expect(game.grid).to be_a(Grid)
    expect(game.grid.x_size).to eq(15)
    expect(game.grid.y_size).to eq(10)
    expect(game.players).to eq([])
    expect(game.turn).to eq(0)
  end

  it 'adds a player in an empty position' do
    player = game.add_player('#000000')
    expect(player.colour).to eq('#000000')
    expect(player.direction).to eq('E') # from starting position config
    expect(game.players).to eq([player])
    expect(game.grid.token_at(2, 2)).to be_a(City)
    expect(game.grid.token_at(2, 2).owner).to eq(player)

    old_player = player
    player = game.add_player('#FF0000')
    expect(player.colour).to eq('#FF0000')
    expect(player.direction).to eq('W') # from starting position config
    expect(game.players).to eq([old_player, player])
    expect(game.grid.token_at(12, 7)).to be_a(City)
    expect(game.grid.token_at(12, 7).owner).to eq(player)

    expect { game.add_player('#FFFFFF') }.to raise_error('No positions left')
  end

  it 'presents positions from config' do
    player = game.add_player('#000000')
    game.grid.remove_token(2, 2)
    position = game.send(:find_vacant_position)
    expect(position['x']).to eq(2)
    expect(position['y']).to eq(2)
    game.grid.add_token(2, 2, Token, game.players[0])
    position = game.send(:find_vacant_position)
    expect(position['x']).to eq(12)
    expect(position['y']).to eq(7)
    position = game.send(:find_vacant_position)
    expect(position['x']).to eq(12)
    expect(position['y']).to eq(7)
    game.grid.add_token(12, 7, Token, game.players[0])
    expect(game.send(:find_vacant_position)).to be_nil
    game.grid.remove_token(12, 7)
    position = game.send(:find_vacant_position)
    expect(position['x']).to eq(12)
    expect(position['y']).to eq(7)
  end

  it "takes the first turn" do
    game.add_player('#000000')
    game.add_player('#FF0000')

    expect(game.turn).to eq(0)
    expect(game.grid.token_at(3, 2)).to be_nil
    expect(game.grid.token_at(11, 7)).to be_nil
    game.take_turn
    expect(game.turn).to eq(1)
    expect(game.grid.token_at(3, 2)).to be_a(Walker)
    expect(game.grid.token_at(3, 2).owner).to eq(game.players[0])
    expect(game.grid.token_at(11, 7)).to be_a(Walker)
    expect(game.grid.token_at(11, 7).owner).to eq(game.players[1])
  end

end
