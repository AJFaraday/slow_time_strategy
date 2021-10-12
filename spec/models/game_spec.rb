require_relative('../../lib/environment')

describe Game do

  let(:game) {Game.new('duel')}

  it 'initializes with a config name' do
    expect(game.grid).to be_a(Grid)
    expect(game.grid.x_size).to eq(15)
    expect(game.grid.y_size).to eq(10)
    expect(game.players).to eq([])
  end

  it 'adds a player in an empty position' do
    player = game.add_player('#000000')
    expect(game.players).to eq([player])
    expect(game.grid.token_at(2,2)).to be_a(City)
    expect(game.grid.token_at(2,2).owner).to eq(player)
  end

end
